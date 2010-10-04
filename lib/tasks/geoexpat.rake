namespace :db do
  desc "Setup the database and load categories"
  task :setup => :environment do
    %w(db:seed categories:update).each do |task|
      Rake::Task[task].invoke
    end
  end
end

namespace :categories do
  desc "Update Geoexpat Classified Categories"
  task :update => :environment do
    puts "== Fetching categories..."
    html = Net::HTTP.get(URI.parse(Geoexpat.classified_category_index_url))
    doc = Nokogiri::HTML.parse(html)
    categories = doc.css('div.foruminfo.td .forumdata a')
    categories.each do |a|
      if cat_id = a[:href][/cat\/(\d+)/, 1]
        Category.find_or_create_by_id(:name => a.text, :id => cat_id) do |cat|
          cat.id = cat_id
          cat.save
        end
      end
    end
    puts "===== Found #{categories.size} categories."
  end
end

namespace :filters do
  desc "Run the classifieds update task for all defined filters"
  task :check => :environment do
    def next_page_link(doc)
      doc.css(".forumhead.foruminfo.L1 div a").detect{|a| a.text == "Next Page" }
    end

    def follow_search_forward_link(doc)
      fwd_link = doc.css('div table td span a').first[:href]
      sleep 1   # Pause for search to process
      search_html = Net::HTTP.get(URI.parse(fwd_link))
      Nokogiri::HTML.parse(search_html)
    end

    def parse_search_page(doc)
      doc.css(".forumrow.table .blockrow table .blockrow .medium a img").xpath("..").each do |link|
        if classified_id = link[:href][/\/classifieds\/showproduct.php\/product\/(\d+)\/title/, 1]
          # Only process the classfied unless we haven't seen it before.
          unless Classified.find_by_geoexpat_id(classified_id)
            puts "== Fetching and parsing classified ad: #{classified_id}..."
            html = Net::HTTP.get(URI.parse(Geoexpat.classified_url(classified_id)))
            parse_classified_page(classified_id, Nokogiri::HTML.parse(html))
          end
        else
          raise "Classified ID could not be found. Please check the site for updates."
        end
      end

      if next_link = next_page_link(doc)
        puts "=== Fetching next page of search results..."
        html = Net::HTTP.get(URI.parse(next_link[:href]))
        parse_search_page(Nokogiri::HTML.parse(html))
      end
    end

    def parse_classified_page(id, doc)
      # Find advertiser username and ID
      link = doc.xpath("//span[. =\"Advertiser Info\"]/../../../tr/td/div/a").first
      geoexpat_user = {:username => link.text,
                       :geoexpat_id  => link[:href][/\?u=(\d+)/, 1] }

      # Find title, description, location
      title       = doc.xpath("//table//td//h1").first.text
      description = doc.xpath("//table//td//b[. =\"Description:\"]/../../td").last.text.strip
      location_el = doc.xpath("//table//td//b[. =\"Location:\"]/../../td").last
      location = location_el ? location_el.text.strip : ""

      # Find detail set
      views, date, condition, price = doc.xpath("//table//td//span[. =\"Date Posted\"]/../../../tr/td[@class=\"blockrow\"]/span/b").map {|n| n.text }
      date = Date.parse_hk(date)
      if price == "Best Offer"
        # Try to find a price from the description
        price = description[/\$([\d\.,]+)/, 1].to_s.gsub(',','').to_f
      else
        price = price[/([\d\.,]+)/,1].to_s.gsub(',','').to_f
      end

      # Find list of photos
      photos = {}
      doc.css(".panelsurround table td a img").each_with_index do |image, i|
        image[:src].match /classifieds\/data\/(\d+)\/thumbs\/(.*\.[A-Za-z]{3,4})/
        folder_id, filename = $1, $2
        photos[i] = {:folder_id => folder_id,
                     :filename  => filename }
      end

      params = { :geoexpat_id => id,
                 :category => @filter.category,
                 :geoexpat_user_attributes => geoexpat_user,
                 :classified_photos_attributes => photos,
                 :title => title,
                 :description => description,
                 :price => price,
                 :views => views.to_i,
                 :condition => condition,
                 :location => location,
                 :list_date => date }

      Classified.create!(params)
      @added_classifieds += 1

    end

    puts "== Fetching classifieds for all defined filters..."
    searched_queries = []
    @added_classifieds = 0

    filter_count = Filter.all.size
    Filter.all.each_with_index do |filter, i|
      @filter = filter
      unless searched_queries.include?(@filter.query)
        searched_queries << @filter.query
        puts "= Searching for '#{@filter.query}'..."
        html = Net::HTTP.post_form(URI.parse(Geoexpat.classified_search_post_url),
                                            {'cat'      => @filter.category.id,
                                             'keywords' => @filter.query }).body
        doc = follow_search_forward_link(Nokogiri::HTML.parse(html))
        parse_search_page(doc)
      end
      # Site requires a minimum delay of 15 seconds between searches.
      if (i+1) < filter_count
        puts "! Waiting for #{Geoexpat.search_delay} second(s) between searches..."
        sleep Geoexpat.search_delay
      end
    end
    puts "===== Scanned #{searched_queries.size} queries."
    puts "===== Added #{@added_classifieds} classifieds."

    last_run_file = File.join(Rails.root, 'config', 'last_run.yml')
    last_run = YAML.load_file(last_run_file) || {}
    last_run["filters:check"] = Time.now

    # Save last run time to a yaml file.
    File.open(last_run_file, "w") do |f|
      f.write(last_run.to_yaml)
    end

  end
end


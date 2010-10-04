module Geoexpat
  class << self
    def base_url
      "http://www.geoexpat.com/"
    end

    def search_delay
      35 #seconds
    end

    def classified_category_index_url
      URI.join(base_url, '/classifieds/index.php').to_s
    end

    def classified_category_url(id)
      URI.join(base_url, '/classifieds/showcat.php/cat/', id.to_s).to_s
    end

    def classified_url(id)
      URI.join(base_url, "/classifieds/showproduct.php/product/", id.to_s).to_s
    end

    def classified_photo_url(folder_id, filename)
      URI.join(base_url, "/classifieds/data/#{folder_id}/#{filename}").to_s
    end

    def classified_photo_thumb_url(folder_id, filename)
      URI.join(base_url, "/classifieds/data/#{folder_id}/thumbs/#{filename}").to_s
    end

    def classified_search_post_url
      URI.join(base_url, "/classifieds/search.php").to_s
    end

    def user_url(id)
      URI.join(base_url, "/forum/member.php?u=#{id.to_s}").to_s
    end

  end
end


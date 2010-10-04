class Filter < ActiveRecord::Base

  cattr_reader :per_page
  @@per_page = 15

  belongs_to :user
  belongs_to :category

  validates_presence_of :user
  validates_presence_of :query
  validates_presence_of :category

  def match?(classified)
    downcase_blob = classified.description.strip.downcase + " " +
                    classified.title.strip.downcase + " " +
                    classified.condition.strip.downcase

    # Check for price range
    return false unless self.from_price <= classified.price and
                        self.to_price   >= classified.price

    # Check for word inclusions/exclusions
    return false if self.contains_all_words.to_s.split(",").detect do |word|
      !downcase_blob.include?(word.strip.downcase)
    end
    return false if not self.contains_any_words.to_s.split(",").detect do |word|
      downcase_blob.include?(word.strip.downcase)
    end and not self.contains_any_words.blank?
    return false if self.contains_no_words.to_s.split(",").detect do |word|
      downcase_blob.include?(word.strip.downcase)
    end

    true
  end

  def matches
    Classified.all.select do |classified|
      self.match? classified
    end
  end

end


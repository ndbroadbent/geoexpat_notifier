class Category < ActiveRecord::Base

  has_many :classifieds
  has_many :filters

  class << self
    def index_url
      Geoexpat.classified_category_index_url
    end
  end
  def url
    Geoexpat.classified_url(self.id)
  end
end


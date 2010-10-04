class GeoexpatUser < ActiveRecord::Base

  has_many :classifieds

  def url
    Geoexpat.user_url(self.geoexpat_id)
  end

end


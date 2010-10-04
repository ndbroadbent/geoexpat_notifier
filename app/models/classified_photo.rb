class ClassifiedPhoto < ActiveRecord::Base

  belongs_to :classified

  validates :filename, :presence => true
  validates :folder_id, :presence => true

  def url
    Geoexpat.classified_photo_url(self.folder_id, self.filename)
  end

  def thumb_url
    Geoexpat.classified_photo_thumb_url(self.folder_id, self.filename)
  end
end


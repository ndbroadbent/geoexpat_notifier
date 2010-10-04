class Classified < ActiveRecord::Base

  cattr_reader :per_page
  @@per_page = 10

  belongs_to :geoexpat_user
  belongs_to :category
  has_many :classified_photos

  accepts_nested_attributes_for :classified_photos

  after_create :find_filter_matches

  validates_presence_of :category

  def url
    Geoexpat.classified_url(self.geoexpat_id)
  end

  def photos
    classified_photos
  end

  def find_filter_matches
    # Collect matching filters and send an email notification to each affected user
    matching_filters = Filter.all.select do |filter|
      filter.match? self
    end
    if matching_filters.any?
      puts "======== '#{self.title}' matched #{matching_filters.size} filter(s), sending notification.."
      unique_users = matching_filters.map{|f| f.user }.uniq
      # Send an email once per unique user.
      unique_users.each do |user|
        # Find a filter for each user to use
        filter = matching_filters.detect{|f| f.user == user }
        Notification.notification_email(user, filter, self).deliver
      end
    end
  end
end


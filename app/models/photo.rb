class Photo < ActiveRecord::Base
  attr_accessible :title, :body, :gallery_id, :name, :image, :remote_image_url
  belongs_to :gallery
  has_many :gallery_users, :through => :gallery, :source => :user
  belongs_to :user
  mount_uploader :image, ImageUploader
  
  LIMIT = 5


  validate do |record|
    record.validate_photo_quota
  end
  
  def self.total_male
    count_of_males = Photo.joins(:user).where(users: {gender: 'male'}).uniq.count
  end
  
  def self.total_female
    count_of_males = Photo.joins(:user).where(users: {gender: 'female'}).uniq.count
  end

  def validate_photo_quota
    return unless self.user
    if self.user.photos(:reload).count >= LIMIT
      errors.add(:base, :exceeded_quota)
    end
  end
end
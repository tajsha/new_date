class Location < ActiveRecord::Base  
  attr_accessible :city, :latitude, :longitude, :zip_code
  has_and_belongs_to_many :users
  scope :by_zip_code, ->(zip_code) { where('zip_code = ?', zip_code) }

end
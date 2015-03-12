class Zip < ActiveRecord::Base
  attr_accessible :city, :latitude, :longitude, :code, :zip_code
  has_and_belongs_to_many :users
  
  validates :code, uniqueness: true
  
    self.primary_key = 'code'
  
    
  def self.code(code)
    find_by(:code => code)
  end
  
  
end
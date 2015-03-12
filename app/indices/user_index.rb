ThinkingSphinx::Index.define :location, :with => :active_record do 
  indexes city 
  
  has "RADIANS(locations.latitude)",  :as => :latitude,  :type => :float
  has "RADIANS(locations.longitude)", :as => :longitude, :type => :float
end 

ThinkingSphinx::Index.define :user, :with => :active_record, :delta => true do 
  indexes name, :as => :user, :sortable => true 
  indexes religion, birthday, about_me, height, career, feet, inches, sexuality, children, user_smoke, user_drink, politics, gender, ethnicity, education, username, zip_code
  has created_at, updated_at 
  has "RADIANS(locations.latitude)",  :as => :latitude,  :type => :float
  has "RADIANS(locations.longitude)", :as => :longitude, :type => :float
  has(:id, :as => :user_id)
  has age
  set_property :wordforms => 'lib/word.txt'
  join location
end 

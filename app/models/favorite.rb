class Favorite < ActiveRecord::Base
  belongs_to :user
   belongs_to :favorite, class_name: "User"

   attr_accessible :user_id
end

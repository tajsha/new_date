class Profile < ActiveRecord::Base
  attr_accessible :feet, :inches, :about_me, :birthday, :career, :children, :education, :email, :ethnicity, :gender, :height, :name, :password_digest, :religion, :sexuality, :user_drink, :user_smoke, :username, :zip_code

def update_profile

end
end
class Gallery < ActiveRecord::Base
   attr_accessible :title, :body, :name
   belongs_to :user
   has_many :photos

end

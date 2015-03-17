class Search < ActiveRecord::Base
  attr_accessible :user_id, :age, :children, :ethnicity, :career, :gender, :religion, :zip_code, :birthday, :max_age, :min_age, :youngest_age, :oldest_age
  
  belongs_to :user
  
  def users
    @users ||= find_users
  end
    
    private
    
    def find_users
      users = User.order(:id)
      users = users.where(gender: gender) if gender.present?
      users = users.where(zip_code: zip_code) if zip_code.present?
      users = users.where(children: children) if children.present?
      users = users.where(religion: religion) if religion.present?
      users = users.where(ethnicity: ethnicity) if ethnicity.present?

      if min_age.present? && max_age.present?
        min = [ min_age, max_age ].min
        max = [ min_age, max_age ].max
        min_date = Date.today - min.years
        max_date = Date.today - max.years
        users = users.where("birthday BETWEEN ? AND ?", max_date, min_date)
        users
      end
      users
    end
  end

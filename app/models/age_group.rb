class AgeGroup
  include ActiveModel::Model # not really necessary, but will add some AM functionality which could be nice later
  attr_accessor :from, :to, :count
end
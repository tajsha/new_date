class AgeGroupsService
  # @params 
  #   ranges - an array of age group ranges. E.g.: [[0, 18], [19, 24], [25, 34], ...]
  #   users - an array of users from which the age groups will be computed. Defaults to all users  
  def initialize(ranges = [], users = User.all.to_a)
    @ranges = ranges
    @users = users
    @age_groups = []
  end

  # Count users in each age group range
  # @return
  #   an array of age groups. E.g.: [{ from: 0, to: 18, count: 12 }, ...]
  def call
    @ranges.each do |range|      
      users = @users.select { |user| user.age >= range[0] && user.age <= range[1] }      
      @age_groups << AgeGroup.new(from: range[0], to: range[1], count: users.length)                
   end
   @age_groups
  end
end
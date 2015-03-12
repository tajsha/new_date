class AddDurationToPlans < ActiveRecord::Migration
  def change
    add_column :plans, :duration, :integer
  end
end

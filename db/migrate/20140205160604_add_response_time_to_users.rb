class AddResponseTimeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :average_response_time, :integer
    add_column :users, :response_rate, :integer
    add_column :users, :response_total, :integer
  end
end

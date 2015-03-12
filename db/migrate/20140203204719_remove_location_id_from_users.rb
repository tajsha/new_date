class RemoveLocationIdFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :location_id, :integer
  end
end

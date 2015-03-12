class AddIndexToUsersZipCode < ActiveRecord::Migration
  def change
    add_index :users, :zip_code
  end
end
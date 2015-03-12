class AddAvatarIdColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :avatar_id, :integer, :default => 1
  end
end

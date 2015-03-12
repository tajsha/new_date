class AddUserIdColumnToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :user_id, :integer
  end
end

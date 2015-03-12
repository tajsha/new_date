class AddCancelledColumnToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :cancelled, :integer
  end
end

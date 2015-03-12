class AddCancellationDateToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :cancellation_date, :string
  end
end

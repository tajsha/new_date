class AddNoEmailColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :no_email, :boolean
  end
end

class AddDeltaToUsers < ActiveRecord::Migration
  def change
	add_column :users, :delta, :boolean, :default => true
	User.update_all({:delta => true}, {:delta => nil})
	change_column :users, :delta, :boolean, :null => false
  end
end

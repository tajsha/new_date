class AddColumnsToSearch < ActiveRecord::Migration
  def change
	add_column :searches, :advanced, :boolean, :default => false
	add_column :searches, :input_text, :text
	add_column :searches, :user_id, :integer, :null => false
  end
end

class AddDefaultphotoidToUser < ActiveRecord::Migration
  def change
    add_column :users, :default_photo_id, :integer
  end
end

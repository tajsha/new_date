class CreatePhotos < ActiveRecord::Migration
  def self.up
    create_table :photos do |t|
      
      t.timestamps
    end
  end
end

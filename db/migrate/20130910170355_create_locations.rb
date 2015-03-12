class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :zipcode
      t.string :city
      t.string :state
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end

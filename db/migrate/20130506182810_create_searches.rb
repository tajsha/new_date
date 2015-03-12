class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :gender
      t.string :age
      t.string :zip_code
      t.string :children
      t.string :religion
      t.string :ethnicity

      t.timestamps
    end
  end
end

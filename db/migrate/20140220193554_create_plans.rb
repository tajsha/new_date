class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :name
      t.decimal :price, :precision => 15, :scale => 10
      t.integer :length

      t.timestamps
    end
  end
end

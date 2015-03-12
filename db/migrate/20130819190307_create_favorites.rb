class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.integer :sender_id
      t.string :recipient_id

      t.timestamps
    end
  end
end

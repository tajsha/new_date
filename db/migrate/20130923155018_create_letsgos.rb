class CreateLetsgos < ActiveRecord::Migration
  def change
    create_table :letsgos do |t|
      t.string :content
      t.integer :user_id
      t.string :tag
      t.integer :repost_from_user_id

      t.timestamps
    end
    add_index :letsgos, [:user_id, :created_at]
  end
end

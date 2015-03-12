class CreateRelationships < ActiveRecord::Migration
  def self.up
    create_table :relationships do |t|
      t.integer  "follower_id"
      t.integer  "followed_id"
    end
  end
  def self.down
    drop_table :relationships
  end
end
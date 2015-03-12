class RemoveColumns < ActiveRecord::Migration
  def self.up
    remove_column :questions, :asked_to, :asked_by
  end
end

class AddMinageAndMaxageToSearch < ActiveRecord::Migration
  def change
    add_column :searches, :min_age, :integer
    add_column :searches, :max_age, :integer
  end
end

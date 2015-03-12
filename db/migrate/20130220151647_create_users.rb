class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :zip_code
      t.string :birthday
      t.string :name
      t.string :username
      t.string :gender
      t.string :ethnicity
      t.string :sexuality
      t.string :career
      t.string :education
      t.string :religion
      t.string :politics
      t.string :children
      t.string :height
      t.string :user_smoke
      t.string :user_drink
      t.string :about_me
      t.string :inches
      t.string :feet
      t.timestamps
    end
  end
end

class AddAvatarColumnToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :avatar, :integer
  end
end

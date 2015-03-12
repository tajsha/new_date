class AddGalleryIdToPhoto < ActiveRecord::Migration
  def change
    add_column :photos, :gallery_id, :string
  end
end

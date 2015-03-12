class AddGalleryIdToGalleries < ActiveRecord::Migration
  def change
    add_column :galleries, :gallery_id, :integer
  end
end

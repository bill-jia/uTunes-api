class AddCoverImageToAlbums < ActiveRecord::Migration
  def change
    add_column :albums, :cover_image, :string
  end
end

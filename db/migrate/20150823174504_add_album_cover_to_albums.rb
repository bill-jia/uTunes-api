class AddAlbumCoverToAlbums < ActiveRecord::Migration
  def change
    add_column :albums, :album_cover, :string
  end
end

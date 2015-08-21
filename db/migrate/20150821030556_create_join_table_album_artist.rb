class CreateJoinTableAlbumArtist < ActiveRecord::Migration
  def change
    create_join_table :albums, :artists do |t|
      # t.index [:album_id, :artist_id]
      # t.index [:artist_id, :album_id]
    end
  end
end

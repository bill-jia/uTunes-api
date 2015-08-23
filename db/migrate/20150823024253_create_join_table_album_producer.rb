class CreateJoinTableAlbumProducer < ActiveRecord::Migration
  def change
    create_join_table :albums, :producers do |t|
      # t.index [:album_id, :producer_id]
      # t.index [:producer_id, :album_id]
    end
  end
end

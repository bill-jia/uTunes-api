class AddDurationToAlbums < ActiveRecord::Migration
  def change
    add_column :albums, :duration, :float
  end
end

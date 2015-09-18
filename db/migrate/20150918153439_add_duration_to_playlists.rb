class AddDurationToPlaylists < ActiveRecord::Migration
  def change
    add_column :playlists, :duration, :float
  end
end

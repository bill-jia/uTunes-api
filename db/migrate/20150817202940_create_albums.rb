class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :title, null: false
      t.integer :year
      t.integer :tracks_count

      t.timestamps null: false
    end
  end
end

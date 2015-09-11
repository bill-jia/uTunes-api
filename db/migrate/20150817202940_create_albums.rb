class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.text :title, null: false
      t.text :year
      t.integer :tracks_count

      t.timestamps null: false
    end
  end
end

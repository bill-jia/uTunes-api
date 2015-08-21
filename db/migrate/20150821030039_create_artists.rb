class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.string :name
      t.integer :class_year
      t.integer :tracks_count

      t.timestamps null: false
    end
  end
end

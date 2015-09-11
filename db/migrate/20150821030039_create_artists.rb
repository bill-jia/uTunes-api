class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.text :name
      t.text :class_year
      t.integer :tracks_count
      t.text :bio

      t.timestamps null: false
    end
  end
end

class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.belongs_to :album, index: true, foreign_key: true
      t.text :title
      t.integer :track_number
      t.float :length_in_seconds
      t.timestamps null: false
    end
  end
end

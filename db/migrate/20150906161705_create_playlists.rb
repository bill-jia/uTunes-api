class CreatePlaylists < ActiveRecord::Migration
  def change
    create_table :playlists do |t|
      t.text :title
      t.text :author
      t.belongs_to :user, index: true, foreign_key: true
      t.boolean :is_public

      t.timestamps null: false
    end
  end
end

class AddCoverDesignerToAlbums < ActiveRecord::Migration
  def change
    add_column :albums, :cover_designer, :string
  end
end

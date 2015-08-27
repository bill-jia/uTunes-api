class AddProfilePictureToArtists < ActiveRecord::Migration
  def change
    add_column :artists, :profile_picture, :string
  end
end

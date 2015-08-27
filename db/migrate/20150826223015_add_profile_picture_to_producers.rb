class AddProfilePictureToProducers < ActiveRecord::Migration
  def change
    add_column :producers, :profile_picture, :string
  end
end

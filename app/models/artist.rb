class Artist < ActiveRecord::Base
	attr_accessor :_remove
	
	has_and_belongs_to_many :albums
	has_and_belongs_to_many :tracks
	mount_uploader :profile_picture, ProfilePictureUploader

	searchable do
		text :name, :class_year
		text :tracks do
			tracks.map(&:title)
		end
		text :albums do
			albums.map(&:title)
		end
	end
end

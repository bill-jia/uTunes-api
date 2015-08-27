class Artist < ActiveRecord::Base
	attr_accessor :remove_association
	
	has_and_belongs_to_many :albums
	has_and_belongs_to_many :tracks
	mount_uploader :profile_picture, ProfilePictureUploader
end

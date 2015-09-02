class Producer < ActiveRecord::Base
  attr_accessor :_remove	
  
  has_and_belongs_to_many :albums
  mount_uploader :profile_picture, ProfilePictureUploader
end

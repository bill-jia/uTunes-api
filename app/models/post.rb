class Post < ActiveRecord::Base
  belongs_to :user
  mount_uploader :cover_image, CoverImageUploader
  validates :title, presence: true
end

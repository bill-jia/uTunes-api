class Playlist < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :tracks
  accepts_nested_attributes_for :tracks
  validates :title, presence: true  

  def public?
  	self.is_public
  end
end

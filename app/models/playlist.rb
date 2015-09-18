class Playlist < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :tracks
  accepts_nested_attributes_for :tracks
  validates :title, presence: true
  before_save :get_duration

  def public?
  	self.is_public
  end

  searchable do
		text :title, :author
		boolean :is_public
		integer :user_id
	end

	def get_duration
		self.duration = 0
		self.tracks.each do |track|
			self.duration += track.length_in_seconds
		end
	end	
end

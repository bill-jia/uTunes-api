class Album < ActiveRecord::Base
	has_many :tracks, dependent: :destroy
	has_and_belongs_to_many :artists
	accepts_nested_attributes_for :tracks, allow_destroy: true

	before_save :get_artists

	def get_artists
	self.artists = Array.new

	self.tracks.each do |track|
		artists = track.artists.collect do |artist|
			Artist.find_or_create_by(name: artist.name, class_year: artist.class_year)
		end
		artists.each do |artist|
			self.artists.push(artist)
		end
	end
end
end

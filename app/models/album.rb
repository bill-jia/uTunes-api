class Album < ActiveRecord::Base
	has_many :tracks
	has_and_belongs_to_many :artists
	has_and_belongs_to_many :producers
	mount_uploader :cover_image, CoverImageUploader

	accepts_nested_attributes_for :tracks, allow_destroy: true
	accepts_nested_attributes_for :producers, allow_destroy: true

	before_save :get_producers, :get_duration
	after_create :get_artists

	searchable do
		text :title, :year
		text :tracks do
			tracks.map(&:title)
		end
		text :artists do
			artists.map(&:name)
		end
		text :producers do
			producers.map(&:name)
		end
	end

	def get_producers
		self.producers = self.producers.collect do |producer|
			Producer.create_with(bio: producer.bio).find_or_create_by(name: producer.name, class_year: producer.class_year)
		end
	end

	def get_duration
		self.duration = 0
		self.tracks.each do |track|
			self.duration += track.length_in_seconds
		end
	end

	def get_artists
		self.artists = Array.new

		self.tracks.each do |track|
			artists = track.artists.collect do |artist|
				Artist.find_by name: artist.name, class_year: artist.class_year
			end
			artists.each do |artist|
					self.artists.push(artist) unless self.artists.include?(artist)
			end
		end
	end
end

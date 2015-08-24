class Track < ActiveRecord::Base
  belongs_to :album, counter_cache: true
  has_and_belongs_to_many :artists, counter_cache: true
  has_attached_file :audio

  accepts_nested_attributes_for :artists, allow_destroy: true

  before_save :get_artists

  def get_artists
    self.artists = self.artists.collect do |artist|
      artist = Artist.create_with(bio: artist.bio).find_or_create_by(name: artist.name, class_year: artist.class_year)
    end
  end

end

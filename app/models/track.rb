class Track < ActiveRecord::Base
  attr_accessor :_remove
  belongs_to :album, counter_cache: true
  has_and_belongs_to_many :artists, -> {order "name, class_year"}
  has_and_belongs_to_many :playlists
  accepts_nested_attributes_for :artists
  mount_uploader :audio, AudioUploader

  before_save :get_artists

  def get_artists
    self.artists = self.artists.collect do |artist|
      artist = Artist.create_with(bio: artist.bio).find_or_create_by(name: artist.name, class_year: artist.class_year)
    end
  end

  searchable do
    text :title
    text :artists do
      artists.map(&:name)
    end
    text :album do
      album.title + (album.year ? " " + album.year : "")
    end
  end
end

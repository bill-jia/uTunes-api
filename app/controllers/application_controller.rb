class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) << :name
      devise_parameter_sanitizer.for(:account_update) << :name
      devise_parameter_sanitizer.for(:account_update) << :role
      devise_parameter_sanitizer.for(:account_update) << :user_role
    end
  def artist_strong_delete(artist, delete_associated_tracks)
    if delete_associated_tracks
      artist.tracks.each do |track|
          track_strong_delete(track)
      end
    end

    if (!artist.destroyed?)
      artist.remove_profile_picture = true
      artist.destroy
    end
  end

  def album_strong_delete(album)
    album.tracks.each do |track|
      logger.debug "Deleting:" + track.title
      track_strong_delete(track)
    end

    album.producers.each do |producer|
      if producer.albums.size == 1
        producer.remove_profile_picture = true
        producer.destroy
      end
    end

    album.remove_cover_image = true
    album.destroy
  end

  def track_strong_delete(track)
    track.artists.each do |artist|
      if artist.tracks.size == 1
        logger.debug "Artist only has this track"
        artist.remove_profile_picture = true
        artist.destroy
      end
    end

    track.remove_audio = true
    track.destroy

    if track.album.tracks.size == 1
       track.album.destroy
    end
  end

end

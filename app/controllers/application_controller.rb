class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Pundit
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) << :name
      devise_parameter_sanitizer.for(:account_update) << :name
      devise_parameter_sanitizer.for(:account_update) << :role
      devise_parameter_sanitizer.for(:account_update) << :user_role
    end
    def update_auth_header

      # cannot save object if model has invalid params
      return unless @resource and @resource.valid? and @client_id

      # Lock the user record during any auth_header updates to ensure
      # we don't have write contention from multiple threads
      @resource.with_lock do

        # determine batch request status after request processing, in case
        # another processes has updated it during that processing
        @is_batch_request = is_batch_request?(@resource, @client_id)

        auth_header = {}

        if not DeviseTokenAuth.change_headers_on_each_request
          auth_header = @resource.build_auth_header(@token, @client_id)

          # update the response header
          response.headers.merge!(auth_header)

        # extend expiration of batch buffer to account for the duration of
        # this request
        elsif @is_batch_request
          auth_header = @resource.extend_batch_buffer(@token, @client_id)
          response.headers['Access-Token']='_BATCH_UNCHANGED_'

        # update Authorization response header with new token
        else
          auth_header = @resource.create_new_auth_token(@client_id)

          # update the response header
          response.headers.merge!(auth_header)
        end

      end # end lock

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

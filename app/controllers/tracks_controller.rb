class TracksController < ApplicationController
  before_action :set_track, only: [:show, :update, :destroy]
  before_action :process_params, only: [:create, :update]

  # GET /tracks
  # GET /tracks.json
  def index
    if params[:album_id]
      @tracks = Album.find(params[:album_id]).tracks
    elsif params[:artist_id]
      @tracks = Artist.find(params[:artist_id]).tracks
    else
      @tracks = Track.all
    end
    render json: @tracks
  end

  # GET /tracks/1
  # GET /tracks/1.json
  def show
    render json: @track
  end

  # POST /tracks
  # POST /tracks.json
  def create
    @track = Track.new(track_params)

    if @track.save
      head :no_content
      # render json: @track, status: :created, location: @track
    else
      render json: @track.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tracks/1
  # PATCH/PUT /tracks/1.json
  def update
    @track = Track.find(params[:id])

    if @track.update(track_params)
      params["track"]["artists_attributes"].each do |artist|
        if artist[:remove_association] == true
          @artist = Artist.find(artist[:id])
          if @artist.tracks.size == 1
            artist_strong_delete(@artist, false)
          end
          @track.artists.delete(@artist)
        end
      end
      head :no_content
    else
      render json: @track.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tracks/1
  # DELETE /tracks/1.json
  def destroy
		track_strong_delete(@track)

    head :no_content
  end

  private

    def set_track
      @track = Track.find(params[:id])
    end

    def process_params
      unless params["file"].blank?
        params["track"] = JSON.parse(params["track"]).with_indifferent_access
        params["track"]["audio"] = params["file"]
        params.delete("file")
      end
      unless params["track"]["artists"].blank?
        params["track"]["artists_attributes"] = params["track"]["artists"]
        params["track"].delete("artists")
      end
      logger.debug params
    end

    def track_params
      params.require(:track).permit(:album_id, :title, :track_number, :length_in_seconds, :_destroy, :audio, artists_attributes: [:id, :name, :class_year, :bio, :remove_association])
    end
end

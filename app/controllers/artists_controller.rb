class ArtistsController < ApplicationController
  before_action :set_artist, only: [:show, :update, :destroy]
  before_action :process_params, only: [:create, :update]
  after_action :verify_authorized, :except => :index
  
  # GET /artists
  # GET /artists.json
  def index
    if params[:search]
      @search = Artist.search do
        fulltext params[:search]
      end
      @artists = @search.results    
    elsif params[:track_id]
      @artists = Track.find(params[:track_id]).artists
    else
      @artists = Artist.all
    end

    render json: @artists
  end

  # GET /artists/1
  # GET /artists/1.json
  def show
    authorize @artist
    render json: @artist
  end

  # POST /artists
  # POST /artists.json
  def create
    @artist = Artist.new(artist_params)
    authorize @artist
    if @artist.save
      head :no_content
    else
      render json: @artist.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /artists/1
  # PATCH/PUT /artists/1.json
  def update
    authorize @artist
    if @artist.update(artist_params)
      head :no_content
    else
      render json: @artist.errors, status: :unprocessable_entity
    end
  end

  # DELETE /artists/1
  # DELETE /artists/1.json
  def destroy
    authorize @artist
    artist_strong_delete(@artist, params[:delete_associated_tracks]=="true")

    head :no_content
  end

  private

    def set_artist
      @artist = Artist.find(params[:id])
    end

    def process_params
      unless params["file"].blank?
        params["artist"] = JSON.parse(params["artist"]).with_indifferent_access
        params["artist"]["profile_picture"] = params["file"]
        params.delete("file")
      end
    end

    def artist_params
      params.require(:artist).permit(:id, :name, :class_year, :tracks_count, :bio, :profile_picture)
    end
end

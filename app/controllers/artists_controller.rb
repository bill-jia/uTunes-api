class ArtistsController < ApplicationController
  before_action :set_artist, only: [:show, :update, :destroy]

  # GET /artists
  # GET /artists.json
  def index
    @artists = Artist.all

    render json: @artists
  end

  # GET /artists/1
  # GET /artists/1.json
  def show
    render json: @artist
  end

  # POST /artists
  # POST /artists.json
  def create
    @artist = Artist.new(artist_params)

    if @artist.save
      head :no_content
    else
      render json: @artist.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /artists/1
  # PATCH/PUT /artists/1.json
  def update
    @artist = Artist.find(params[:id])

    if @artist.update(artist_params)
      head :no_content
    else
      render json: @artist.errors, status: :unprocessable_entity
    end
  end

  # DELETE /artists/1
  # DELETE /artists/1.json
  def destroy
    @artist.destroy

    head :no_content
  end

  private

    def set_artist
      @artist = Artist.find(params[:id])
    end

    def artist_params
      params.require(:artist).permit(:name, :class_year, :tracks_count)
    end
end

class AlbumsController < ApplicationController
  before_action :set_album, only: [:show, :update, :destroy]
  before_action :process_params, only: [:create, :update]

  # GET /albums
  # GET /albums.json
  def index
    if params[:search]
      @search = Album.search do
        fulltext params[:search]
      end
      @albums = @search.results
    elsif params[:artist_id]
      @albums = Artist.find(params[:artist_id]).albums
    elsif params[:producer_id]
      @albums = Producer.find(params[:producer_id]).albums
    else
      @albums = Album.all
    end
    render json: @albums
  end

  # GET /albums/1
  # GET /albums/1.json
  def show
    render json: @album
  end

  # POST /albums
  # POST /albums.json
  def create
    @album = Album.new(album_params)

    if @album.save
      head :no_content
      # render json: @album, status: :created, location: @album
    else
      render json: @album.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /albums/1
  # PATCH/PUT /albums/1.json
  def update
    @album = Album.find(params[:id])

    if @album.update(album_params)
      if params["album"]["producers_attributes"]
        params["album"]["producers_attributes"].each do |producer|
          if producer[:_remove] == true
            @producer = Producer.find(producer[:id])
            if @producer.albums.size == 1
              @producer.destroy
            end
            @album.producers.delete(@producer)
          end
        end
      end
      head :no_content
    else
      render json: @album.errors, status: :unprocessable_entity
    end
  end

  # DELETE /albums/1
  # DELETE /albums/1.json
  def destroy
    album_strong_delete(@album)

    head :no_content
  end

  private

    def set_album
      @album = Album.find(params[:id])
    end

    def process_params
      files = params.values.find_all { |value| value.class == ActionDispatch::Http::UploadedFile }

      unless files.empty?
        params["album"] = JSON.parse(params["album"]).with_indifferent_access
        if params["album"]["tracks"]
          offset_value = files.length - params["album"]["tracks"].length
        end
        if !offset_value || offset_value == 1
          params["album"]["cover_image"] = files[0]
        end
      end
      unless params["album"]["tracks"].blank?
        params["album"]["tracks_attributes"] = params["album"]["tracks"]
        params["album"]["tracks_attributes"].each_with_index do |track_params, index|
          unless track_params["artists"].blank?
            track_params["artists_attributes"] = track_params["artists"]
          end
          track_params.delete("artists")
          track_params["audio"] = files[index+offset_value]
          track_params.delete("file")          
        end
      end
      params["album"].delete("tracks")
      params.delete("file")
      unless params["album"]["producers"].blank?
        params["album"]["producers_attributes"] = params["album"]["producers"]
      end
      params["album"].delete("producers")
    end

    def album_params
      params.require(:album).permit(:title, :year, :tracks_count, :cover_image, :description, :cover_designer, producers_attributes: [:id, :name, :class_year, :bio, :_destroy, :_remove],
      tracks_attributes: [{artists_attributes:[:id, :name, :class_year, :bio, :_destroy]}, :id, :title, :track_number, :length_in_seconds, :_destroy, :album_id, :audio])
    end
end

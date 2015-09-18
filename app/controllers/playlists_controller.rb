class PlaylistsController < ApplicationController
  before_action :set_playlist, only: [:show, :update, :destroy]
  before_action :process_params, only: [:create, :update]
  after_action :verify_authorized, :except => :index
  
  # GET /playlists
  # GET /playlists.json
  def index
    logger.debug "Is a user signed in?"
    logger.debug user_signed_in?
    if params[:user_id]
      @playlists = User.find(params[:user_id]).playlists
    elsif !current_user
      if params[:search]
        @search = Playlist.search do
          fulltext params[:search]
          all_of do
            with(:is_public, true)
          end
        end
        @playlists = @search.results
      else
        @playlists = Playlist.where(is_public: true)
      end
    elsif current_user.role == "user"
      if params[:search]
        @search = Playlist.search do
          fulltext params[:search]
          any_of do
            with(:is_public, true)
            with(:user_id, current_user.id)
          end
        end
        @playlists = @search.results        
      else
        @playlists = Playlist.where("user_id = " + current_user.id.to_s + " OR is_public = TRUE")
      end
    else
      if params[:search]
        @search = Playlist.search do
          fulltext params[:search]
        end
        @playlists = @search.results       
      else
        @playlists = Playlist.all
      end 
    end
    render json: @playlists
  end

  # GET /playlists/1
  # GET /playlists/1.json
  def show
    authorize @playlist
    render json: @playlist
  end

  # POST /playlists
  # POST /playlists.json
  def create
    @playlist = Playlist.new(playlist_params)
    authorize @playlist
    if @playlist.save
      @user = User.find(params[:playlist][:user_id])
      @user.playlists << @playlist
      @user.save      
      head :no_content
    else
      render json: @playlist.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /playlists/1
  # PATCH/PUT /playlists/1.json
  def update
    @playlist = Playlist.find(params[:id])
    authorize @playlist
    for track in params[:playlist][:tracks_attributes]
      if track[:_remove]==nil
        @playlist.tracks << Track.find(track[:id])
      end
    end
    if @playlist.update(playlist_params)
      if params[:playlist][:tracks_attributes]
        params[:playlist][:tracks_attributes].each do |track|
          if track[:_remove]
            @track = Track.find(track[:id])
            @playlist.tracks.delete @track
            @track._remove = false
          end
        end
      end
      @playlist.save
      head :no_content
    else
      render json: @playlist.errors, status: :unprocessable_entity
    end
  end

  # DELETE /playlists/1
  # DELETE /playlists/1.json
  def destroy
    @playlist.destroy
    authorize @playlist
    head :no_content
  end

  private

    def process_params
      unless params["playlist"]["tracks"].blank?
        params["playlist"]["tracks_attributes"] = params["playlist"]["tracks"]
        params["playlist"].delete("tracks")
      end
    end

    def set_playlist
      @playlist = Playlist.find(params[:id])
    end

    def playlist_params
      params.require(:playlist).permit(:id, :title, :author, :user_id, :is_public, tracks_attributes: [:_remove, :id])
    end
end

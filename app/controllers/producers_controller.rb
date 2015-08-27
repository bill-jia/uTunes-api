class ProducersController < ApplicationController
  before_action :set_producer, only: [:show, :update, :destroy]
  before_action :process_params, only: [:create, :update]
  
  # GET /producers
  # GET /producers.json
  def index
    if params[:album_id]
      @producers = Album.find(params[:album_id]).producers
    else
      @producers = Producer.all
    end
    render json: @producers
  end

  # GET /producers/1
  # GET /producers/1.json
  def show
    render json: @producer
  end

  # POST /producers
  # POST /producers.json
  def create
    @producer = Producer.new(producer_params)

    if @producer.save
      head :no_content
    else
      render json: @producer.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /producers/1
  # PATCH/PUT /producers/1.json
  def update
    @producer = Producer.find(params[:id])

    if @producer.update(producer_params)
      head :no_content
    else
      render json: @producer.errors, status: :unprocessable_entity
    end
  end

  # DELETE /producers/1
  # DELETE /producers/1.json
  def destroy
    @producer.destroy

    head :no_content
  end

  private

    def set_producer
      @producer = Producer.find(params[:id])
    end

    def process_params
      unless params["file"].blank?
        params["producer"] = JSON.parse(params["producer"]).with_indifferent_access
        params["producer"]["profile_picture"] = params["file"]
        params.delete("file")
      end
    end

    def producer_params
      params.require(:producer).permit(:name, :class_year, :bio, :albums_count, :role, :profile_picture)
    end
end

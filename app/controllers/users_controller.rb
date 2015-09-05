class UsersController < ApplicationController
  before_filter :authenticate_user!
  after_action :verify_authorized

	def index
		@users = User.all
    authorize User
    render json: @users
	end

	def show
		@user = User.find(params[:id])
    authorize @user
    render json: @user
	end

	def create
		@user = User.new(params[:user])
    if @user.save
      head :no_content
    else
      render json: @user.errors, status: :unprocessable_entity
    end
	end

  def update
    @User = User.find(params[:id])
    params[:user].delete(:password) if params[:user][:password].blank?
    params[:user].delete(:password_confirmation) if params[:user][:password_confirmation]
    if @User.update(User_params)
      head :no_content
    else
      render json: @User.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
    	head :no_content
    end
  end
end

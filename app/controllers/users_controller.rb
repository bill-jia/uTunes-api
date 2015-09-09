class UsersController < ApplicationController
  before_filter :authenticate_user!
  after_action :verify_authorized

	def index
		@users = User.where.not(id: current_user.id)
    authorize @users
    render json: @users
	end

	def show
		@user = User.find(params[:id])
    authorize @user
    render json: @user
	end

	def create
		@user = User.new(params[:user])
    authorize @user
    if @user.save
      head :no_content
    else
      render json: @user.errors, status: :unprocessable_entity
    end
	end

  def update
    @user = User.find(params[:id])
    if current_user.valid_password?(params[:user][:admin_password])
      params[:user].delete(:admin_password)
      authorize @user
      if @user.update(user_params)
        head :no_content
      else
        render json: @User.errors, status: :unprocessable_entity
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    if current_user.valid_password?(params[:admin_password])
      authorize @user
      if @user.destroy
      	head :no_content
      end
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :role, :admin_password)
    end  
end

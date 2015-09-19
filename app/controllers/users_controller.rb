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
    authorize @user
    
    if current_user.valid_password?(params[:user][:admin_password])
      params[:user].delete(:admin_password)
      if @user.update(user_params)
        head :no_content
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    else
      @user.errors.add(:admin_password, "admin password incorrect")
      render json: @user.errors, status: :unprocessable_entity      
    end
  end

  def destroy
    @user = User.find(params[:id])
    authorize @user
    if current_user.valid_password?(params[:admin_password])
      if @user.destroy
      	head :no_content
      end
    else
      @user.errors.add(:admin_password, "admin password incorrect")
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :role, :admin_password)
    end  
end

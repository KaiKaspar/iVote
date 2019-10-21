class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update]
  before_action :authentication_required, except: [:new, :create]

  def index
    @users = User.search(params[:search])
    if params[:commit]
      if @users.count == 1 || @users.count != User.all.count
        cookies.delete :search
      else
        cookies[:search] = "No usernames match this search"
      end
    else
      cookies.delete :search
    end
  end

  def leaderboard
    @users = User.all
    @user = User.find(current_user.id)
  end

  def upgrade
    @user = User.find(current_user.id)
  end

  def show
    @votes = Vote.all
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
    @profile_pictures = ProfilePicture.all
  end

  def create
    @user = User.new(user_params)
    if @user.valid?
      @user.save
      session[:user_id] = @user.id
      redirect_to polls_path
    else
      flash[:user_error] = @user.errors.full_messages
      redirect_to new_user_path
    end
  end

  def edit

  end

  def update
    @user = User.find(params[:id])
    if @user.valid?
      @user.update(user_params)
      redirect_to @user
      flash[:update_success] = 'Profile successfully updated!'
    else
      flash[:user_error] = @user.errors.full_messages
      render :edit
    end
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :user_type, :password, :email, :profile_picture_id)
  end
end

class UsersController < ApplicationController

  before_action :authenticate_user!

  def index
    @users = User.page(params[:page]).per(5)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
       redirect_to users_path
    else
      render 'edit'
    end
  end

  def deatroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end

  def bookmark
    @user = current_user
    @bookmarks = Bookmark.where(user_id: @user).page(params[:page]).per(5)
  end

  private

  def user_params
    params.require(:user).permit(:name, :department, :user_code, :image)
  end
end

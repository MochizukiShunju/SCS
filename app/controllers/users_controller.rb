class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to users_path
  end

  def deatroy
    @user.destroy
    redirect_to users_path
  end

  def bookmark
  end

  private

  def user_params
    params.require(:user).permit(:name, :group, :user_code)
  end
end

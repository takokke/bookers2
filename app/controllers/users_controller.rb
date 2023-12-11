class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  
  def index
    @users = User.all
    @book = Book.new
  end
  
  def show
    @user = User.find(params[:id])
    @book = Book.new()
    @books = @user.books.all
    @following_users = @user.following_users
    @follower_users = @user.follower_users
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(id: @user.id)
    else
      render "edit"
    end
  end
  
  # フォロー一覧
  def follows
    user = User.find(params[:id])
    @users = user.following_users
  end
  
  # フォロワー一覧
  def followers
    user = User.find(params[:id])
    @users = user.follower_users
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
  
  def is_matching_login_user
    user = User.find(params[:id])
    unless user == current_user
      redirect_to user_path(id: current_user.id)
    end
  end
end

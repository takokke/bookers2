class UsersController < ApplicationController
  
  def index
    @users = User.all
    @book = Book.new
  end
  
  def show
    @user = User.find(params[:id])
    @book = Book.new()
    @books = @user.books.all
  end
  
  def edit
    @user = current_user
  end
  
  def update
    
  end
  
  def user_params
    params.require(:user).permit(:name, :profile_image)
  end
  
  
end

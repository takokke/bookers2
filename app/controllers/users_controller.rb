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
  
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
  
  
end

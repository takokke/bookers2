class UsersController < ApplicationController
  
  def index
    
  end
  
  def show
    @user = User.find(params[:id])
    @book = Book.new()
    @books = @user.books.all
  end
  
  def edit
  end
  
  
end

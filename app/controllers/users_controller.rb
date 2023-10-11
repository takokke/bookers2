class UsersController < ApplicationController
  
  def index
    
  end
  
  def show
    @user = User.find(params[:id])
    @book = @user.books.build
  end
  
  def edit
  end
  
  
end

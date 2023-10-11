class BooksController < ApplicationController
  def index
    @book = books.new
    @books = Book.all
  end
  
  def create
    @book = books.new
    @book.user_id = current_user.id
    @book.save
    redirect_to book_path(id: @book.id)
  end

  def edit
  end

  def show
  end
  
  private
  
  def book_params
    params.require(:book).permit(:title, :body)
  end
  
end

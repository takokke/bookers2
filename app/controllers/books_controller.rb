class BooksController < ApplicationController
  def index
    @book = Book.new()
    @books = Book.all
  end
  
  def create
    @book = Book.new(book_params)
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

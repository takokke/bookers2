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
    @book = current_user.books.find(params[:id])
  end

  def update
    @book = current_user.books.find(params[:id])
    @book.update(book_params)
    redirect_to book_path(id: @book.id)
  end

  def show
    @book = Book.find(params[:id])
    @newBook = Book.new()
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end

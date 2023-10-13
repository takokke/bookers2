class BooksController < ApplicationController
  before_action :is_matching_author, only: [:edit, :update]
  
  def index
    @book = Book.new()
    @books = Book.all
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(id: @book.id)
    else
      @books = Book.all
      render "index"
    end
  end

  def edit
    @book = current_user.books.find(params[:id])
  end

  def update
    @book = current_user.books.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(id: @book.id)
    else
      render "edit"
    end
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

  def is_matching_author
    author = Book.find(params[:id]).user
    unless author == current_user
      redirect_to books_path
    end
  end

end

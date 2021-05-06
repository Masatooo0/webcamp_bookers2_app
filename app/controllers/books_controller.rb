class BooksController < ApplicationController
  before_action :correct_user, only: [:new, :create, :edit, :update, :destroy]


  def index
    @book = Book.new
    @books = Book.all
    @user = current_user
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if  @book.save
      flash[:notice] ="You have created book successfully."
      redirect_to book_path(@book)
    else
      @user = current_user
      @books = Book.all
      render :index
    end
  end

  def show
    @newbook = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
  end
  def edit
    @book.user = current_user
    @book = Book.find(params[:id])
  end

  def update
    @book.user = current_user
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice]="Book was successfully updated."
      redirect_to book_path(@book)
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    if @book.destroy
      flash[:notice]="Book was successfully destroyed."
      redirect_to books_path
    end
  end
  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
  def correct_user
     book = Book.find(params[:id])
     # belong_toのおかげでnoteオブジェクトからuserオブジェクトへアクセスできる。
     if current_user.id = book.user.id
       redirect_to books_path
     end
  end
end

class UsersController < ApplicationController
  before_action :baria_user, only: [:edit, :destroy, :update]

  def show
    @user = User.find(params[:id])
    @books = @user.books.page(params[:page]).reverse_order
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] ="You have created book successfully."
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def index
    @users = User.all
    @user = current_user
    @book = Book.new
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def baria_user
    user = User.find(params[:id])
    if current_user != user
      redirect_to user_path(current_user)
    end
  end

end

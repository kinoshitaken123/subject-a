class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update]

  def show
     @user = User.find(params[:id])
     @book = Book.new
     @books = Book.where(user_id: @user.id)
  end

  def index
    @user = current_user
    @users = User.all
    @book = Book.new
    @books = Book.all
  end  

  def edit
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to user_path(current_user)
    end
  end

  def update
    if @user.update(user_params)
      redirect_to users_path(@user), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end

class BooksController < ApplicationController
  before_action :authenticate_user!


  def show
    @book = Book.find(params[:id])
    @book_new = Book.new
    @book_comment = BookComment.new
  end

  def index
    @user = current_user
    @books = Book.all
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id

    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all

      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end



  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
   if @book.destroy
      flash[:notice]="Book was successfully destroyed."
      redirect_to books_path
   end
  end

  def weekly_rank
  	 @ranks = Book.last_week
  	 #Book.Joins(:favorites).where(favorites: { created_at:  0.days.ago.prev_week..0 .days.ago.prev_week(:sunday)}.group(:id).order("count(*) desc"))
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def ensure_correct_user
      @book = Book.find(params[:id])
    unless @book.user == current_user
        redirect_to books_path
    end
  end

end

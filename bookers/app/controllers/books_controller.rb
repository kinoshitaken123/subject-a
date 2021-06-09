class BooksController < ApplicationController
  before_action :authenticate_user!

  impressionist :actions=> [:show, :index]

  def show
    @book = Book.find(params[:id])
    #同じ人アクセス（同じブラウザからアクセス）した複数回、同じ記事をみた場合は1PV
    #impressionist(@book, nil, unique: [:session_hash])
    @book_new = Book.new
    @book_comment = BookComment.new
  end

  def index
    @ranks = Book.last_week_ranks
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

  def self.last_week_ranks
  # left_joinsメソッドとは、関連するレコードが有る無しに関わらずレコードのセットを取得してくれるメソッドです
    relation = Book.left_joins(:favorites)
    relation.merge(Favorite.where(created_at: (1.week.ago.beginning_of_day)..(Time.zone.now.end_of_day) ))
  # favaritesのnilのデータも取得したいのでnilを設定する
    relation = Book.left_joins(:favorites)
            .or(relation.where(favorites: {created_at: nil}))
            .group(:id)
            .order("count(favorites.id) desc")
  # favaritesのnilのデータも取得したいのでnilを設定する
  # desc 多い順
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

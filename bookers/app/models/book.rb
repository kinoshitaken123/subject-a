class Book < ApplicationRecord

	belongs_to :user, optional: true #Userモデルと1：N

	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}

  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def self.last_week_ranks
    # 
    relation = Book.left_joins(:favorites)
    relation.merge(Favorite.where(created_at: (1.week.ago.beginning_of_day)..(Time.zone.now.end_of_day) ))
            .or(relation.where(favorites: {created_at: nil}))
            .group(:id)
            .order("count(favorites.id) desc")
  end
end 
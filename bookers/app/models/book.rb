class Book < ApplicationRecord

	belongs_to :user, optional: true #Userモデルと1：N

	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}

  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
now = Time.current
  def self.last_week_ranks
    Book.joins(:favorites)
        .where(favorites: { created_at: (0.days.ago.prev_week)..(0.days.ago.prev_week(:sunday)) })
        .group(:id)
        .order("count(*) desd")
  end

end

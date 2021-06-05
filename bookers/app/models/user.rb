class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, uniqueness: true, length: { minimum: 2, maximum: 20}
  validates :introduction, length: { maximum: 50}
  
  has_many :books,dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy # フォローしている人取得(Userのfollowerから見た関係)
  has_many :followed, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy # フォローされている人取得(Userのfolowedから見た関係)
  has_many :followings, through: :follower, source: :followed # 自分がフォローしている人
  has_many :followers, through: :followed, source: :follower  # 自分をフォローしている人(自分がフォローされている人)
  
  attachment :profile_image
  # ユーザーをフォローする
  def follow(user_id)
     follower.create(followed_id: user_id)
  end
  # ユーザーのフォローを外す
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end
  # フォロー確認をおこなう
  def following?(user)
    followings.include?(user)
  end

  
end

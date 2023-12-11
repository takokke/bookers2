class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
        
  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_one_attached :profile_image
  
  # フォローする相手が複数いる
  has_many :followers, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # フォローしてくれる相手が複数いる
  has_many :followeds, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  
  # 自分がフォローしているユーザを取得
  has_many :following_users, through: :followers, source: :followed
  # 自分をフォローしてくれているユーザを取得
  has_many :follower_users, through: :followeds, source: :follower
    
  
  validates :name, uniqueness: true
  validates :name, length: { minimum: 2, maximum: 20 }
  
  validates :introduction, length: { maximum: 50 }
  
  
  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/default-image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end
  
  #　フォローしたときの処理
  def follow(user_id)
    followers.create(followed_id: user_id)
  end
  
  #　フォローを外すときの処理
  def unfollow(user_id)
    followers.find_by(followed_id: user_id).destroy
  end
  
  #  指定したユーザーをフォローしていればtrueを返す
  def following?(user)
    following_users.include?(user)
  end
  
end
class Book < ApplicationRecord
  
  has_many :favorites, dependent: :destroy
  belongs_to :user
  
  validates :title, presence: true
  
  validates :body, presence: true
  validates :body, length: { maximum: 200 }
  
  def favorited_by?(user)
    favorites.find_by(user_id: user.id).present?
  end
end

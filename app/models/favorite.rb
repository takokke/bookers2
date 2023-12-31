class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :book
  #validates_uniqueness_of :book_id, scope: :user_id
  
  validates :user_id, uniqueness: { scope: :book_id }
end

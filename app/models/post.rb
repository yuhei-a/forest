class Post < ApplicationRecord
  belongs_to :user

  has_many :likes, dependent: :destroy

  attachment :post_image
  
  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end
end

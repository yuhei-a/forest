class Post < ApplicationRecord
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  #タグ機能
  has_many :tag_tables, dependent: :destroy
  has_many :tags, through: :tag_tables, dependent: :destroy

  attachment :post_image

  #すでに良いねをしているか確認する
  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end

  def save_tags(post_tags)
    post_tags.each do |new_name|
    post_tag = Tag.find_or_create_by(name: new_name)
    self.tags << post_tag
   end
  end
end

class Post < ApplicationRecord
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :unlikes, dependent: :destroy

  #タグ機能
  has_many :tag_tables, dependent: :destroy
  has_many :tags, through: :tag_tables

  attachment :post_image

  validates :title, presence: true, length: { in: 2..80 }
  validates :content, presence: true


  #すでに良いねをしているか確認する
  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end

  def unliked_by?(user)
    unlikes.where(user_id: user.id).exists?
  end

  def save_tags(post_tags)
    post_tags.each do |new_name|
    post_tag = Tag.find_or_create_by(name: new_name)
    self.tags << post_tag
   end
  end

  def update_tags(post_tags)
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    old_tags = current_tags - post_tags
    new_tags = post_tags - current_tags

    old_tags.each do |old|
      self.tags.delete Tag.find_by(name: old)
    end
    new_tags.each do |new|
      post_tag = Tag.find_or_create_by(name: new)
      self.tags << post_tag
    end
  end

end

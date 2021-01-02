class Post < ApplicationRecord
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  #タグ機能
  has_many :tag_tables, dependent: :destroy
  has_many :tags, through: :tag_tables

  #通知機能
  has_many :notifications, dependent: :destroy

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

  def save_tags(post_tags)
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

  def create_notification_like!(current_user)
     temp = Notification.where(["visiter_id = ? and visited_id = ? and post_id = ? and type = ?",current_user.id, user_id, id, 'like'])

     if temp.blank?
       notification = current_user.active_notifications.new(
        post_id: id,
        visited_id: user_id,
        type: 'like')

         if notification.visiter_id == notification.visited_id
           notification.checked = true
         end
          notification.save if notification.valid?
     end
  end

  def create_notification_comment!(current_user, post_comment_id)
    temp_ids = PostComment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, post_comment_id, temp_id['user_id'])
    end
   save_notification_comment!(current_user, post_comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, post_comment_id, visited_id)
    notification = current_user.active_notifications.new(
      post_id: id,
      post_comment_id: post_comment_id,
      visited_id: visited_id,
      type: 'comment')

      if notification.visiter_id == notification.visited_id
        notification.checked == true
      end
      notification.save if notification.valid?
  end
end

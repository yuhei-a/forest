class RelationshipsController < ApplicationController

  def create
   current_user.follow(params[:user_id])
   redirect_to request.referer
  end

  def destroy
   current_user.unfollow(params[:user_id])
   redirect_to request.referer
  end

  #フォロー一覧
  def following
   @following = current_user.following_user
   @like_posts = Like.where(user_id: current_user.id)
   @recent_post = Post.limit(5).order(Arel.sql(" created_at DESC "))
   @tag_list = Tag.joins(:posts)
  end

  def followed
   @followed = current_user.followed_user
   @like_posts = Like.where(user_id: current_user.id)
   @recent_post = Post.limit(5).order(Arel.sql(" created_at DESC "))
   @tag_list = Tag.joins(:posts)
  end
end

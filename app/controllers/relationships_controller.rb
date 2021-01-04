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
  end

  def followed
   @followed = current_user.followed_user
  end
end

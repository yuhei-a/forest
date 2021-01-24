class UnlikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @unlike = current_user.unlike.new(post_id: @post.id)

    if @like = Like.find_by(user_id: current_user.id, post_id: @post.id)
       @like.save
    end

    @unlike.save
  end

  def destroy
    @post = Post.find(params[:post_id])
    unlike = current_user.unlike.find_by(post_id: @post.id)
    unlike.destroy
  end
end

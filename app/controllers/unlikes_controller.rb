class UnlikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    unlike = current_user.unlike.new(post_id: @post.id)
    unlike.save
    redirect_to posts_path
  end

  def destroy
    @post = Post.find(params[:post_id])
    unlike = current_user.unlike.find_by(post_id: @post.id)
    unlike.destroy
    redirect_to posts_path
  end
end

class SearchesController < ApplicationController
  def search
    @item = params["item"]
    @users = User.where('name LIKE ?', '%'+@item+'%')
    @posts = Post.where('title LIKE ?', '%'+@item+'%')
    @like_posts = Like.where(user_id: current_user.id)
  end
end

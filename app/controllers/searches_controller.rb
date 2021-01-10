class SearchesController < ApplicationController
  def search
    @item = params["item"]
    @users = User.where('name LIKE ?', '%'+@item+'%')
    @posts = Post.where('title LIKE ?', '%'+@item+'%')
    @like_posts = Like.where(user_id: current_user.id)
    @recent_post = Post.limit(5).order(" created_at DESC ")
    @tag_list = Tag.joins(:posts)
  end
end

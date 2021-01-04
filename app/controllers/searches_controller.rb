class SearchesController < ApplicationController
  def search
    @item = params["item"]
    @users = User.where('name LIKE ?', '%'+@item+'%')
    @posts = Post.where('title LIKE ?', '%'+@item+'%')
  end
end

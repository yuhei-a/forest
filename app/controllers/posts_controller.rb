class PostsController < ApplicationController
  def index
    @post = Post.new
  end

  def show
    @post = Post.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.find(params[:id])
    @post.save
    redirect_to request.referer
  end

end

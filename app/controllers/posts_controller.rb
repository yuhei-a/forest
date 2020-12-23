class PostsController < ApplicationController
  def index
    @posts = Post.all
    @post = Post.new
  end

  def show
    @postdet = Post.find(params[:id])
    @post = Post.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.save
    redirect_to request.referer
  end

 def edit
   @post = Post.find(params[:id])
 end

 def update
   @post = Post.find(params[:id])
   @post.update(post_params)
   redirect_to posts_path
 end

 def destroy
   @postdetail = Post.find(params[:id])
   @postdetail.destroy
   redirect_to posts_path
 end

  private
  def post_params
  params.require(:post).permit(:title, :content, :post_image)
  end

end

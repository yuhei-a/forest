class PostsController < ApplicationController
  def index
    @tag_list = Tag.all
    @post = Post.all
    @postnew = current_user.posts.new
  end

  def show
    @post = Post.find(params[:id])
    @post_tag = @post.tags
    @postnew = Post.new
    @post_comment = PostComment.new
    @user = @post.user
  end

  def create
    @post = current_user.posts.new(post_params)
    tag_list = params[:post][:name].split(nil)
    if @post.save
       @post.save_tags(tag_list)
       redirect_to request.referer
    else
  　    redirect_to request.referer
    end
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

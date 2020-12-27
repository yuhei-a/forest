class PostsController < ApplicationController
  def index
    @tag_list = Tag.all
    @post = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @post_tag = @post.tags
    @post_comment = PostComment.new
    @user = @post.user
  end

  def new
    @postnew = current_user.posts.new
  end

  def create
    @post = current_user.posts.new(post_params)
    tag_list = params[:post][:name].split(nil)
    if @post.save
       @post.save_tags(tag_list)
       redirect_to posts_path
    else
  　    redirect_to request.referer
    end
  end

 def edit
   @post = Post.find(params[:id])
   @tag_list = @post.tags.pluck(:name).join(nil)
 end

 def update
   @post = Post.find(params[:id])
   tag_list = params[:post][:name].split(nil)
   if @post.update_attributes(post_params)
      @post.save_tags(tag_list)
      redirect_to post_path(@post)
   else
      redirect_to post_path(@post)
   end
 end

 def destroy
   @postdetail = Post.find(params[:id])
   @postdetail.destroy
   redirect_to posts_path
 end

 def ranking
   @posts = Post.find(Like.group(:post_id).order('count(post_id) desc').pluck(:post_id))
 end

 def image
   @images = Post.select(:post_image_id)
 end

  private
  def post_params
  params.require(:post).permit(:title, :content, :post_image)
  end

end

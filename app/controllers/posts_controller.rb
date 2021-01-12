class PostsController < ApplicationController

  def index
    @posts = Post.page(params[:page]).per(5)
    @like_posts = Like.where(user_id: current_user.id)
    @recent_post = Post.limit(5).order(Arel.sql(" created_at DESC "))
    @tag_list = Tag.joins(:posts)
  end

  def show
    @post = Post.find(params[:id])
    @post_tag = @post.tags
    @post_comment = PostComment.new
    @user = @post.user
    @like_posts = Like.where(user_id: current_user.id)
    @recent_post = Post.limit(5).order(Arel.sql(" created_at DESC "))
    @tag_list = Tag.joins(:posts)
  end

  def new
    @post = current_user.posts.new
    @like_posts = Like.where(user_id: current_user.id)
  end

  def create
    @post = current_user.posts.new(post_params)
    tag_list = params[:post][:name].split(nil)
    if @post.save
       @post.save_tags(tag_list)
       redirect_to posts_path, notice: "投稿を作成しました。"
    else
      @like_posts = Like.where(user_id: current_user.id)
      render :new
    end
  end

 def edit
   @post = Post.find(params[:id])
   @tag_list = @post.tags.pluck(:name).join(nil)
   @like_posts = Like.where(user_id: current_user.id)
 end

 def update
   @post = Post.find(params[:id])
   tag_list = params[:post][:name].split(nil)
   if @post.update_attributes(post_params)
      @post.update_tags(tag_list)
      redirect_to post_path(@post), notice: "投稿を更新しました。"
   else
      @like_posts = Like.where(user_id: current_user.id)
      render :edit
   end
 end

 def destroy
   @post = Post.find(params[:id])
   @post.destroy
   redirect_to posts_path
 end

 #タグの検索
 def search
   @tag = Tag.find(params[:tag_id])
   @posts = @tag.posts.all
   @like_posts = Like.where(user_id: current_user.id)
   @recent_post = Post.limit(5).order(Arel.sql(" created_at DESC "))
   @tag_list = Tag.joins(:posts)
 end

 def ranking
   @ranks = Kaminari.paginate_array(Post.find(Like.group(:post_id).order('count(post_id) desc').pluck(:post_id))).page(params[:page]).per(5)
   @like_posts = Like.where(user_id: current_user.id)
   @recent_post = Post.limit(5).order(Arel.sql(" created_at DESC "))
   @tag_list = Tag.joins(:posts)
 end

 def image
   @images = Post.select(:post_image_id)
   @like_posts = Like.where(user_id: current_user.id)
   @recent_post = Post.limit(5).order(Arel.sql(" created_at DESC "))
   @tag_list = Tag.joins(:posts)
 end

  private
  def post_params
  params.require(:post).permit(:title, :content, :post_image)
  end

end

class UsersController < ApplicationController
  before_action :guest_check, only: :unsubscribe

  def index
    @users = User.page(params[:page]).per(5)
    @recent_post = Post.limit(5).order(Arel.sql(" created_at DESC "))
    @like_posts = Like.where(user_id: current_user.id)
    @tag_list = Tag.joins(:posts)
  end

  def show
    @user = User.find(params[:id])
    @my_posts = @user.posts
    @like_post = Like.where(user_id: current_user.id)
    @recent_post = Post.limit(5).order(Arel.sql(" created_at DESC "))
    @like_posts = Like.where(user_id: current_user.id)
    @tag_list = Tag.joins(:posts)
  end

  def edit
    @user = User.find(params[:id])
    @like_posts = Like.where(user_id: current_user.id)
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
       redirect_to user_path(current_user), notice: "ユーザー情報を更新しました。"
    else
      @like_posts = Like.where(user_id: current_user.id)
      render :edit
    end
  end

  def image
   @images = Post.where(user_id: current_user.id).select(:post_image_id, :id)
   @like_posts = Like.where(user_id: current_user.id)
   @recent_post = Post.limit(5).order(Arel.sql(" created_at DESC "))
   @tag_list = Tag.joins(:posts)
  end

  def unsubscribe
   @user = User.find(params[:id])
   @like_posts = Like.where(user_id: current_user.id)
   @recent_post = Post.limit(5).order(Arel.sql(" created_at DESC "))
   @tag_list = Tag.joins(:posts)
  end

  def withdraw
    @user = User.find(current_user.id)
    @user.update(is_valid: false)
    reset_session
    redirect_to root_path
  end

  def top; end

  def about; end

  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction, :gender, :prefectures, :sign, :bloodtype)
  end

  def guest_check
    if current_user.email == 'guest@guest.com'
     redirect_to posts_path, notice: "ゲストユーザーは退会できません。"
    end
  end
end

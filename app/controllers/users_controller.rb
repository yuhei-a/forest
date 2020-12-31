class UsersController < ApplicationController
  def index
    @user = User.all
  end

  def show
    @user = User.find(params[:id])
    @recent_post = Post.limit(5).order(" created_at DESC ")
    @other_user = User.order("RANDOM()").last
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(current_user)
  end

  def top; end

  def about; end

  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction, :gender, :prefectures, :sign, :bloodtype)
  end
end

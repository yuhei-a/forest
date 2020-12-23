class UsersController < ApplicationController
  def index
    
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def top; end
  
  def about; end
end

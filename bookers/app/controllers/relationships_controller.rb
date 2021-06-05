class RelationshipsController < ApplicationController
  before_action :set_user
  
  def create
    current_user.follow(params[:user_id])
    redirect_to request.referer
  end

  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end
  
  def followings
    # binding.pry
    @user = User.find(params[:user_id])
    @users = @user.followings
    
  end

  def followers
    @user = User.find(params[:user_id])
    @users = @user.followers
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end

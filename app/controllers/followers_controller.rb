class FollowersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end



  def create
    if params[:todo] == 'follow'
      Follower.create(followed_id: params[:button].to_i, follower_id: current_user.id)
    elsif params[:todo] == 'unfollow'
      Follower.find_by(followed_id: params[:button].to_i, follower_id: current_user.id).destroy()
    end
      redirect_back(fallback_location: root_path)
  end
end

class CommentsController < ApplicationController
  def create
    @comment = Comment.create(user_id: current_user.id, poll_id: params[:poll_id].to_i, text: params[:text])
    redirect_to poll_path(Poll.find(params[:poll_id]))
  end
end

class VotesController < ApplicationController
  def create
    @vote = Vote.create(user_id: current_user.id, poll_id: params[:poll_id].to_i, vote: params[:button])
    poll_creator = Poll.find(params[:poll_id].to_i).user

    current_user.update(score: (current_user.score + 2))
    poll_creator.update(score: (poll_creator.score + 1))

    redirect_to polls_path
  end
end

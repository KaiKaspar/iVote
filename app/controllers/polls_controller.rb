class PollsController < ApplicationController
  def index
    if params[:filter]
      @filter = params[:filter]
      cookies[:filter] = @filter
    else
      @polls = all_polls
      if cookies[:filter]
        @filter = cookies[:filter]
      end
    end

    if @filter == 'all'
      all_polls
    elsif @filter == 'follow'
      followers_only
    elsif @filter == 'polls'
      polls_only
    elsif @filter == 'answers'
      answers_only
    elsif @filter == 'date_desc'
      @polls = Poll.all
    elsif @filter == 'date_asc'
      @polls = Poll.all.reverse
    end
  end

  def polls_only
    array = []
    Poll.all.each do |p|
      p.votes.map{|v| v.user_id}.exclude?(current_user.id)? array << p : nil
    end
    @polls = array.reverse
  end

  def answers_only
    array = []
    ids = current_user.votes.map{|p| p.poll_id}
    ids.each do |id|
      array << Poll.find(id)
    end
    @polls = array.reverse
  end

  def followers_only
    array = []
    answered = []
    questions = []
    user_ids = Follower.where(follower_id: current_user.id).map{|f| f.followed_id}
    user_ids.each do |id|
      Poll.where(user_id: id).each do |p|
        p.votes.map{|v| v.user_id}.exclude?(current_user.id)? questions << p : answered << p
      end
    end
    questions.reverse.each {|q| array << q}
    answered.reverse.each {|a| array << a}
    @polls = array
  end

  def all_polls
    array = []
    polls_only.each {|p| array << p}
    answers_only.each {|p| array << p}
    @polls = array
  end

  def show
    @poll = Poll.find(params[:id])
  end

  def new
    @poll = Poll.new
  end

  def create
    @poll = Poll.create(poll_params)
    creating_user = User.find(session[:user_id])
    current_score = creating_user.score
    if creating_user.user_type == 'free'
      creating_user.update(score: (current_score - 10))
    end
    redirect_to @poll
  end

  def filter

  end

  private

  def poll_params
    params.require(:poll).permit(:user_id, :question, :answer_one, :answer_two)
  end
end

class VotesController < ApplicationController
  def create
    authorize
    @question = params[:question_id] ? Question.find(params[:question_id]) : nil
    @answer = params[:answer_id] ? Answer.find(params[:answer_id]) : nil
    if @question
      @vote = @question.votes.new(vote_params)
    elsif @answer
      @vote = @answer.votes.new(vote_params)
    end
    @vote.user = current_user
    @question ||= @answer.question
    if @vote.save
      flash[:notice] = "Your vote has been saved!"
    else
      flash[:alert] = "Something went wrong!"
    end
    redirect_to question_path(@question)
  end

  def update
  end

  def destroy
  end
private
  def vote_params
    params.require(:vote).permit(:is_upvote)
  end
end

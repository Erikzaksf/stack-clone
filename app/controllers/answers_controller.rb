class AnswersController < ApplicationController
  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    if @answer.save
      flash[:notice] = "Answer saved successfully."
      redirect_to question_path(@question)
    else
      flash[:alert] = "Something went wrong!"
      redirect_to question_path(@question)
    end
  end
  private
    def answer_params
      params.require(:answer).permit(:content)
    end
end

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

  def edit
    @question = Question.find(params[:question_id])
    @answer = @question.answers.find(params[:id])
    if current_user == @answer.user
      render template: "questions/show"
    else
      flash[:alert] = "You aren't authorized to do that."
      redirect_to question_path(@question)
    end
  end

  def update
    @question = Question.find(params[:question_id])
    @answer = @question.answers.find(params[:id])
    if current_user == @answer.user
      if @answer.update(answer_params)
        flash[:notice] = "Answer updated successfully!"
        redirect_to question_path(@question)
      else
        flash[:alert] = "Something went wrong!"
        render template: "questions/show"
      end
    else
      flash[:alert] = "You aren't authorized to do that."
      redirect_to question_path(@question)
    end
  end

  def destroy
    @question = Question.find(params[:question_id])
    @answer = @question.answers.find(params[:id])
    if current_user == @answer.user
      @answer.destroy
      flash[:notice] = "Answer deleted successfully!"
    else
      flash[:alert] = "You aren't authorized to do that."
    end
    redirect_to question_path(@question)
  end

  private
    def answer_params
      params.require(:answer).permit(:content)
    end
end

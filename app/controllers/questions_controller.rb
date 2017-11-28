class QuestionsController < ApplicationController
  def index
    @questions = Question.all
  end

  def show
    @question = Question.find(params[:id])
  end

  def new
    authorize
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    @question.user = current_user
    if @question.save
      flash[:notice] = "Question posted successfully!"
      redirect_to question_path(@question)
    else
      flash[:alert] = "Something went wrong!"
      render :new
    end
  end

  def edit
    @question = Question.find(params[:id])
    if @question.user == current_user
      render :edit
    else
      flash[:alert] = "You aren't authorized to access that."
      redirect_to question_path(@question)
    end
  end

  def update
    @question = Question.find(params[:id])
    if @question.user == current_user
      if @question.update(question_params)
        flash[:notice] = "Question updated successfully!"
        redirect_to question_path(@question)
      else
        flash[:alert] = "Something went wrong!"
        render :edit
      end
    else
      flash[:alert] = "You aren't authorized to do that."
      redirect_to question_path(@question)
    end
  end

  def destroy
    @question = Question.find(params[:id])
    if @question.user == current_user
      @question.votes.each do |vote|
        vote.destroy
      end
      @question.destroy
      flash[:notice] = "Question deleted successfully!"
      redirect_to questions_path
    else
      flash[:alert] = "You aren't authorized to do that."
      redirect_to question_path(@question)
    end
  end

private
  def question_params
    params.require(:question).permit(:title, :content)
  end
end

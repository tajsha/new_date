class AnswersController < ApplicationController
  
  def new
    @question = Question.find(params[:question_id])
  end
  
  def show
    @question = Question.find(params[:question_id])
    @answer = Answer.find(params[:id])
  end
  
  def create
    @question = Question.find(params[:question_id])
    if @question.update_attributes(params[:question])
      conversation = @question.conversation
      conversation.move_to_trash(current_user)
      redirect_to conversations_path
    else
      render :new
    end
  end
end

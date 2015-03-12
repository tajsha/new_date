class QuestionsController < ApplicationController
  respond_to :js, :html


   def show
      @question = Question.find(params[:id])
      @questions = Question.order("created_at DESC")
      respond_with(@questions)
    end

    def create
      @question = Question.new(params[:question])
      if @question.save
        #NOTE: @messagei is actually an object of Receipt
        @message = current_user.send_message(@question.recipient, @question.question, "You have a question from #{@current_user}") 
        @question.update(:conversation_id => @message.notification.conversation.id)
        redirect_to :back, notice: 'Your question was saved successfully. Thanks!'
      else
        render :new, alert: 'Sorry. There was a problem saving your question.'
      end
    end
    
    
    def destroy
      @question = Question.find(params[:id])
      @question.destroy
      redirect_to :back
    end
  end
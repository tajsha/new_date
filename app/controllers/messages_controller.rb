class MessagesController < ApplicationController
  
  def index
      redirect_to conversations_path(:box => @box)
    end
 
  # GET /message/new
  def new
    @message = current_user.messages.new
  end
 
   # POST /message/create
  def create
    @recipient = User.find(params[:user])
    current_user.send_message(@recipient, params[:body], params[:subject])
    flash[:notice] = "Message has been sent!"
    redirect_to :conversations
  end
  
  def askout
      @recipient = User.find(params[:user])
      current_user.send_message(@recipient, "Let's Go...#{params[:body]}", params[:subject])
      flash[:notice] = "Message has been sent!"
      redirect_to :back, notice: "Your date was sent"
    end
   
end
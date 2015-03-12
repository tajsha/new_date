class ProfileController < ApplicationController
  
  def new
    @user = User.new
  end
  
  def create
     @user = User.new(user_params)
      if @user.save
        redirect_to root_url, notice: "Profile updated!"
      else
        render "new"
      end
    end
    
    private
    
     def user_params
       params.require(:user).permit(:name)
     end 
  end
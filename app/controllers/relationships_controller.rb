class RelationshipsController < ApplicationController


  def create
    @user = User.find(params[:relationship] [:followed_id] )
    current_user.follow!(@user)
    redirect_to @user
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
    redirect_to @user
  end
    
  def set_follow
    @user = User.find(params[:user_id])
    if params[:follow]=="true"
      current_user.follow!(@user)
    else
      current_user.unfollow!(@user)
    end
    respond_to do |format|
      format.js {render '/relationships/set_follow.js'}
    end
  end
end
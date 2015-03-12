class FavoritesController < ApplicationController
  before_filter :require_login

  def create
    @favorite = current_user.favorites.create!(:user_id => params[:user_id])
    redirect_to :back, notice: "Added friend."
  end

  def destroy
    @favorite = current_user.favorites.find(params[:id])
    @favorite.destroy
    redirect_to :back, notice: "Removed friendship."
  end
end
class LetsgosController < ApplicationController
  #load_and_authorize_resource
  def create
    @letsgo = current_user.letsgos.build(letsgo_params)
    if @letsgo.save
      flash[:success] = "Date posted!"
      redirect_to :back
else
      flash[:error] = "Date was not posted!"
      redirect_to :back
end
end

def show
  @letsgo = Letsgo.find(username: params[:id])
  authorize! :read, @letsgo
  
end
  
  def destroy
    @letsgo = Letsgo.find(params[:id])
    @letsgo.destroy
    redirect_to :back
  end
  
  def index    
    limit = params['page'].present? ? params['page'].to_i * 10 : 0
    location_zipcodes = Location.select(:zip_code).where(:state => current_user.location.state).map(&:zip_code)
        genders = if current_user.gender.downcase == 'male'
				  if current_user.sexuality.downcase == 'gay'
				    ["Male"]
				  elsif current_user.sexuality.downcase == 'straight'
				    ["Female"]
				  else
				    ["Male", "Female"]
				  end
				else
				  if current_user.sexuality.downcase == 'gay'
				    ["Female"]
				  elsif current_user.sexuality.downcase == 'straight'
				    ["Male"]
				  else
				    ["Male", "Female"]
				  end
				end
    user_ids = User.select(:id).where(:zip_code => location_zipcodes, :gender => genders)
    @letsgos = Letsgo.where("repost_from_user_id IS NULL AND user_id IN (?)", user_ids).order("created_at ASC").offset(limit).limit(10)    
    @page = params['page'].present? ? (params['page'].to_i+1) : 1    
    render layout: 'new_application'    
  end

def eatdrink
  @eatdrink = Letsgo.where(:tag => 'Eat/Drink').where("repost_from_user_id IS NULL")
end

def listenwatch
  @listenwatch = Letsgo.where(:tag => 'Listen/Watch').where("repost_from_user_id IS NULL")
end

def play
  @play = Letsgo.where(:tag => 'Play').where("repost_from_user_id IS NULL")
end

def explore
  @explore = Letsgo.where(:tag => 'Explore').where("repost_from_user_id IS NULL")
end

def other
  @other = Letsgo.where(:tag => 'Other').where("repost_from_user_id IS NULL")
end

def repost
  @letsgo = Letsgo.find(params[:id]).repost(current_user)
    redirect_to root_url
  end
  
  def random
    @letsgo = Letsgo.random.first
    if request.xhr?      
    end
  end
  
  def interested
    @letsgo = Letsgo.find(params[:id])
    @content = @letsgo.content
    @recipient = @letsgo.user
    @receipt = current_user.send_message(@recipient, "Let's go...#{@content}", "#{@current_user} is Interested in your date!")
    if request.xhr?
		render :json => {:success => true}
    else
		redirect_to :back, notice: "Your message was sent"
	end
  end

private

def letsgo_params
  params.require(:letsgo).permit(:content, :tag)
end

def correct_user
  @letsgo = current_user.letsgos.find_by(id: params[:id])
  redirect_to root_url if @letsgo.nil?
end
end

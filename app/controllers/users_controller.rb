class UsersController < ApplicationController
  respond_to :html, :json
  
  def age_group
  age_group_service = AgeGroupsService.new([[18, 24], [25, 34], [35, 44], [45, 100]])
  @age_groups = age_group_service.call
end
  
  def settings
    @user = User.find(params[:id])
    render layout: 'new_application'
  end
  
  def speed_date
    user_ids = Letsgo.all.map(&:user_id).uniq
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
		   user_ids = User.select(:id).where(["id IN (?) AND gender IN (?)", user_ids, genders]).map(&:id)
           @users = User.search(:geo => [current_user.latitude * Math::PI / 180.0, current_user.longitude * Math::PI / 180.0],
            :with  => {:geodist => 0.0..100_000.0, :user_id => user_ids},
            :order => 'geodist ASC', :without => {:user_id => current_user.id}).shuffle
	render layout: 'new_application'
  end
  
  def new
    @user = User.new
    render layout: 'new_application'
  end
  
  def profile
    @profile = User.profile
    @user = User.find_by(username: params[:id])
    @question = Question.where(recipient_id: params[:id]).first
  end
  
  def create
    if params["user"]["male_sexuality"].present? and params["user"]["female_sexuality"].present?
      params["user"][:sexuality] = 'bisexual'
    elsif params["user"]["male_sexuality"].present?
      params["user"][:sexuality] = 'gay' if params["user"]["gender"] == 'Male'
      params["user"][:sexuality] = 'straight' if params["user"]["gender"] == 'Female'
    elsif params["user"]["female_sexuality"].present?
      params["user"][:sexuality] = 'gay' if params["user"]["gender"] == 'Female'
      params["user"][:sexuality] = 'straight' if params["user"]["gender"] == 'Male'
    end
    @user = User.new(user_params)
    if @user.save
      UserMailer.registration_confirmation(@user).deliver
      session[:user_id] = @user.id
      redirect_to root_url, notice: "Thank you for signing up!"
    else
      render "new"
    end
  end

  def show
    @user = User.find_by(username: params[:id])
    @question = @user.questions.page(params[:page]).per_page(3)
    @letsgos = @user.letsgos.paginate(page: params[:page], :per_page => 3)
    @letsgo = current_user.letsgos.build
    @similar_users = @user.similar.shuffle.first(8)
    respond_to do |format|
      format.html { render layout: 'new_application' }
      format.js { render partial: '/letsgos/letsgo_paging', locals: {letsgos: @letsgos} } if params[:letsgo]
      format.js { render partial: 'questions/questions', locals: {questions: @question} }
    end
  end
    
  def edit
    @user = User.find_by(username: params[:id])
  end
  
  def index
    @user = current_user
    @search = Search.new
    page = params[:page] || 1
     if @user.present?
		@users = User.search(:without => {:user_id => @user.id}, :page => page, :per_page => 4, :order => 'created_at DESC')
	 else
		@users = User.search(:page => page, :per_page => 4, :order => 'created_at DESC')
	 end
	 
    if request.xhr?
		render :partial => 'user', :layout => false, :collection => @users
    else
		render layout: 'new_application'    
	end
  end
  
  def destroy
    @user = User.find_by(username: params[:id]).destroy
    @user.destroy
    flash[:success] = "User deleted."
    redirect_to :back
  end
  
  def update
    @user = if current_user.has_role?(:admin)
      User.find_by(username: params[:id])
    else
      current_user
    end
    params[:user].delete("user_id")
    @user.update_attributes(params[:user])
    respond_with @user
  end
    
  def follow
    @title = "Following"
    @user = User.find_by(username: params[:id])
    friend = User.find_by(username: params[:id])
    current_user.follow! friend unless current_user.following? friend
    @users = @user.followed_users(page: params[:page])-[current_user]
    render 'show_follow', layout: 'new_application'  
  end

  def unfollow
    friend = User.find_by(username: params[:id])
    current_user.unfollow! friend
    redirect_to friend
  end
    
  def follow_popup
    @user = User.find_by(username: params[:id])
    respond_to do |format|
      format.js {}
    end
  end
    
  def update_stripe_billing
    @user = current_user
    customer = Stripe::Customer.retrieve(@user.subscription.stripe_customer_token)
    customer.cards.retrieve(@user.subscription.stripe_card_id).delete()
    customer.cards.create({
        card: {
          number: params[:user][:scardnumber],
          exp_month: params[:user][:sexp_month],
          exp_year: params[:user][:sexp_year],
          cvc: params[:user][:scvc],
          name: params[:user][:sname],
          address_line1: params[:user][:sbilling_address1],
          address_line2: params[:user][:sbilling_address2],
          address_city: params[:user][:saddress_city],
          address_zip: params[:user][:saddress_zip],
          address_state: params[:user][:saddress_state],
          address_country: params[:user][:saddress_country]
        }
      })
    if customer.save!
      @user.stripe_card_id = customer.active_card.id
      @user.save!
      flash.alert = 'Billing information updated successfully!'
      redirect_to root_url
    else
      flash.alert = 'Stripe error'
      redirect_to root_url
    end
  end

  def search
    @users = ThinkingSphinx.search(params[:query])
    @search = Search.new
    render :index, layout: 'new_application'
  end
     
  private
    
    
  def user_params
    params.require(:user).permit(:name, :email, :username, :password, :ethnicity, :gender, :zip_code, :birthday, :role, :age, :sexuality, :user_sex)
  end
end

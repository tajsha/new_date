class AdminController < ApplicationController
  before_filter :authorized?
  
  def index
    @user = current_user
    @users = @user.present? ? User.where('id != ?',@user.id) : User.all
    @users = User.includes(subscription: :plan).paginate(:per_page => 20, :page => params[:page])
    @users = @users.where.not(id: current_user.id) if current_user
    @letsgos = Letsgo.where("repost_from_user_id IS NULL").all
    @questions = Question.all
    @photos = Photo.all
    render layout: 'new_application'    
  end
  
  def show
    @user = User.find_by(username: params[:id])
    @users = User.all
    @question = @user.questions.page(params[:page]).per_page(3)
    @letsgos = @user.letsgos.paginate(page: params[:page], :per_page => 3)
    @letsgo = current_user.letsgos.build
    respond_to do |format|
      format.html { render layout: 'new_application' }
      format.js { render partial: '/letsgos/letsgo_paging', locals: {letsgos: @letsgos} } if params[:letsgo]
      format.js { render partial: 'questions/questions', locals: {questions: @question} }
    end
  end
  
  def users
      @user = current_user
      @users = User.all      
      @users = User.includes(subscription: :plan).paginate(:per_page => 20, :page => params[:page])
      age_group_service = AgeGroupsService.new([[18, 24], [25, 34], [35, 44], [45, 100]])
      @age_groups = age_group_service.call
      render layout: 'new_application'    
  end
  
  def subscriptions
      @user = current_user
      @users = User.all
      @users = User.includes(subscription: :plan).paginate(:per_page => 20, :page => params[:page])
      render layout: 'new_application'    
  end

  def letsgo
      @user = current_user
      @users = User.all      
      @letsgos = Letsgo.where("repost_from_user_id IS NULL").all
      render layout: 'new_application'    
  end
  
  def pictures
      @user = current_user
      @photos = Photo.all
      render layout: 'new_application'    
  end
  
  def qanda
      @user = current_user
      @users = User.all      
      @questions = Question.all
      render layout: 'new_application'    
  end
  
  def messages
      @user = current_user
      @users = User.all
      render layout: 'new_application'    
  end
  
  private
  def authorized?
    unless current_user.has_role? :admin
      flash[:error] = "You are not authorized to view that page."
      redirect_to root_path
    end
  end
end
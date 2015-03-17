class ApplicationController < ActionController::Base
  protect_from_forgery
  
  around_filter :user_time_zone, if: :current_user
  
   before_action :set_search 

private

def my_helper
  if current_user.has_cancelled?
    redirect_to root_path
  end
end

def current_user
  @current_user ||= User.find_by_auth_token(cookies[:auth_token]) if cookies[:auth_token]
  end
  helper_method :current_user
  
    def user_time_zone(&block)
      Time.use_zone(current_user.time_zone, &block)
    end
    
    def set_search
	@search_option = current_user.search if @current_user.present?
	end 
  end

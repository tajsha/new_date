class WebhooksController < ApplicationController
  
  	skip_before_filter :verify_authenticity_token

  	def subscription_event
      case params[:type]
  		  when "customer.subscription.deleted"
  		  	puts "--in if-------------------"
  		  	customer_id = params[:data][:object][:customer]
  	   		customer = Stripe::Customer.retrieve(customer_id)
  				#customer.subscriptions.retrieve(params[:data][:object][:id]).delete(:at_period_end => true)
  		    user_subscription = Subscription.find_by(stripe_customer_token: customer_id)
  				user_subscription.update_column("cancelled",1) if user_subscription.present?
  			end		
  		render :nothing => true, :status => 200, :content_type => 'text/html' 
  	end
  end
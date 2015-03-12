class NotificationsController < ApplicationController
  protect_from_forgery :except => :paypal_ipn
  
  
   def create
      params.permit! # Permit all Paypal input params
      #query = params
      puts "in method*************************************"   
      #query[:cmd] = "_notify-validate"
      if  params[:txn_type] == 'subscr_cancel'
       user_subscription = Subscription.find_by(paypal_customer_token: params[:payer_id])
       user_subscription.update_column("cancelled",1) if user_subscription.present?
      end
      render :text => 'OK'
    end
  end
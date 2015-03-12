class SubscriptionsController < ApplicationController
  
  def new
    plan_id = params[:plan_id] || 1
    plan = Plan.find(plan_id)
    @subscription = plan.subscriptions.build
    if params[:PayerID]
      @subscription.paypal_customer_token = params[:PayerID]
      @subscription.paypal_payment_token = params[:token]
      @subscription.email = @subscription.paypal.checkout_details.email
    end
    render layout: 'new_application'
    
  end

  def create
    @user = current_user
    @subscription = Subscription.new(params[:subscription])
    if @subscription.save_with_payment
      UserMailer.subscriber(@user).deliver
      redirect_to @subscription, :notice => "Thank you for subscribing!"
    else
      render :new
    end
  end

  def show
    @subscription = Subscription.find(params[:id])
    render layout: 'new_application'
  end
  
  def paypal_checkout
    plan = Plan.find(params[:plan_id])
    subscription = plan.subscriptions.build
    redirect_to subscription.paypal.checkout_url(
      return_url: new_subscription_url(:plan_id => plan.id),
      cancel_url: root_url
    )
  end
    
    def updatesubscription
      @user = current_user
      @customer = Stripe::Customer.retrieve(@user.subscription.stripe_customer_token)
      if @user.subscription.plan_id == 12
      @customer.update_subscription(:plan => "1", :prorate => true)
      current_user.subscription.update_attributes(:plan_id => 1)
      flash.alert = 'Your subscription has been changed to monthly!'
      redirect_to root_url
    elsif @user.subscription.plan_id == 1
      @customer.update_subscription(:plan => "12", :prorate => true)
      current_user.subscription.update_attributes(:plan_id => 12)
     current_user.save!
      flash.alert = 'Your subscription has been changed to annually!'
      redirect_to root_url
    end
     end

     def cancelsubscription
       @user = current_user
         @customer = Stripe::Customer.retrieve(@user.subscription.stripe_customer_token)
         @customer.cancel_subscription(:at_period_end => true) 
         current_user.save!
         flash.alert = 'Your subscription has been cancelled successfully!'
         redirect_to root_url
       end
       
       def showcard
         @user = current_user
         Stripe::Customer.retrieve(@user.subscription.stripe_customer_token).cards.all()
       end
           
           def suspend
             @user = current_user
             @user.subscription.suspend_paypal
             current_user.subscription.update_attributes(:cancelled => 1)
               flash.alert = 'Billing has been suspended!'
                redirect_to root_url
           end

           def reactivate
             @user = current_user
             @user.subscription.reactivate_paypal
             current_user.subscription.update_attributes(:cancelled => nil)
               flash.alert = 'Billing has been activated!'
                redirect_to root_url
           end
         
     
               def edit_card
                 @user = current_user
               end

               def update_card
                 @user = current_user
                 card_info = {
                   name:    params[:name],
                   number:    params[:number],
                   exp_month: params[:date][:month],
                   exp_year:  params[:date][:year],
                   cvc:       params[:cvc]
                 }
                 if @user.subscription.update_card(@subscriber, card_info)
                   flash.alert = 'Saved. Your card information has been updated.'
                   redirect_to root_url
                 else
                   flash.alert = 'Stripe reported an error while updating your card. Please try again.'
                   redirect_to root_url
                 end
               end
end

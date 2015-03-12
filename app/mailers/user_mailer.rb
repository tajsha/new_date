class UserMailer < ActionMailer::Base
  default from: "no-reply@areyoutaken.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  
  def registration_confirmation(user)
    @user = user
    mail(:to => user.email, :subject => "Registered")
  end
  
  def password_reset(user)
    @user = user
    mail :to => user.email, :subject => "Password Reset"
  end
  
  def subscriber(user)
    @user = user
    mail(:to => user.email, :subject => "Congrats! Here's Your Subscription Information")
  end
end
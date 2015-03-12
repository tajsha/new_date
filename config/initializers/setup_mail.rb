ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "areyoutaken.com",
  :user_name            => "cwilson05@gmail.com",
  :password             => "series2k",
  :authentication       => "plain",
  :enable_starttls_auto => true
}



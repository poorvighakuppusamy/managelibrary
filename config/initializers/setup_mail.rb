ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.smtp_settings = {
  :address => "smtp.gmail.com",
  :port => 587,
  :domain => "whatever.org",
  :user_name => "poorvirasi@gmail.com",
  :password => "kspr@2130",
  :authentication => "plain",
  :enable_starttls_auto => true
  }
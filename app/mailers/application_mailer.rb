# app/mailers/application_mailer.rb

class ApplicationMailer < ActionMailer::Base
  default from: Rails.env.test? ? "noreply@example.com" : ENV["FROM_MAIL_ADDRESS"]
  layout "mailer"
end

class LeadMailer < ApplicationMailer
  default from: 'notifications@uber-crm.com'
  
  def welcome_email(user)
    @user = user
    @url = root_url
    mail(to: @user.email, subject: 'Добро пожаловать в UberCRM!')
  end
  
  def send_lead(recipient_email, lead)
    @user = current_user
    @lead = lead
    track user: @user
    mail(to: recipient_email, subject: "Новый лид")
  end
end

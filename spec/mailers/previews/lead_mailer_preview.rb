# Preview all emails at http://localhost:3000/rails/mailers/lead_mailer
class LeadMailerPreview < ActionMailer::Preview
  def welcome_email
    LeadMailer.welcome_email(User.first)
  end
  
  def send_lead
    LeadMailer.send_lead('just.me.sober@gmail.com', Lead.first)
  end
end

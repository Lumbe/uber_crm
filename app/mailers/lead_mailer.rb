class LeadMailer < ApplicationMailer
  default from: 'office@servus.km.ua'

  def send_lead(recipient_email, sender, lead)
    @lead = lead
    track user: sender
    mail(to: recipient_email, subject: "Новый лид")
  end
end

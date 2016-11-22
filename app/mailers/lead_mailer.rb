class LeadMailer < ApplicationMailer
  default from: "Сервус Поділля <crm.servus@gmail.com>"

  def send_lead(recipient_email, sender, lead)
    @lead = lead
    track user: sender
    mail(to: recipient_email, subject: "Новый лид")
  end
end

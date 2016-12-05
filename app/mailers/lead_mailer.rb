class LeadMailer < ApplicationMailer
  default from: "Mailgun Test <postmaster@sandbox6c18ff9554cc49aeab97c7fad99c0440.mailgun.org>"

  def send_lead(recipient_email, sender, lead)
    @lead = lead
    mail(to: recipient_email, subject: "Новый лид")
  end
end

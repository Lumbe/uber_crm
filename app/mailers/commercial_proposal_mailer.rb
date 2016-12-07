class CommercialProposalMailer < ApplicationMailer
  default from: "Сервус Поділля <postmaster@sandbox6c18ff9554cc49aeab97c7fad99c0440.mailgun.org>"
  add_template_helper ApplicationHelper

  def send_commercial_proposal(contact, manager, commercial_proposal)
    @contact = contact
    @commercial_proposal = commercial_proposal
    @manager = manager
    mail(to: contact.email, subject: "Стоимость Вашего дома")
  end
end

class CommercialProposalMailer < ApplicationMailer
  default from: 'Сервус <office@servus.km.ua>'
  add_template_helper ApplicationHelper

  def mail(headers = {}, &block)
    message = super(headers.except(:observer_args, :interceptor_args), &block)
    if headers[:observer_args].present?
      message.class_eval { attr_accessor :observer_args }
      message.observer_args = headers[:observer_args]
    end
    if headers[:interceptor_args].present?
      message.class_eval { attr_accessor :interceptor_args }
      message.interceptor_args = headers[:interceptor_args]
    end
    message
  end

  def send_commercial_proposal(contact, manager, commercial_proposal)
    @contact = contact
    @commercial_proposal = commercial_proposal
    @manager = manager
    mail to: contact.email,
        from: "#{@contact.department.name} <#{@contact.department.email}>",
        subject: 'Стоимость Вашего дома',
        observer_args: { user: @manager, commercial_proposal: @commercial_proposal }
  end
end

class LeadMailer < ApplicationMailer
  default from: "Сервус <office@servus.km.ua>"
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

  def send_lead(recipient_email, sender, lead)
    @lead = lead
    @user = sender
    mail from: @lead.department.email,
        to: recipient_email,
        subject: "Новый лид",
        observer_args: {user: @user, lead: @lead}
  end
end

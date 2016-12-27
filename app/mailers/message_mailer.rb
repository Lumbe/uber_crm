class MessageMailer < ApplicationMailer
  default from: "Сервус Поділля <office@mg.servus.vn.ua>"
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

  def send_mail(message, user)
    @message = message
    @user = user
    mail to: @message.to,
        from: "#{@user.first_name} #{@user.last_name} <#{@user.email}>",
        subject: @message.subject,
        observer_args: { user: @user, message: @message }
  end
end

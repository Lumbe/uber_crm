class MessagesController < ApplicationController
  protect_from_forgery with: :exception, except: [:delivered, :opened], prepend: true
  prepend_before_action :auth_user_before_action, only: [:delivered, :opened]

  def index
    @messages = Message.where(commercial_proposal: nil).where(inbound: true)
    @user = current_user
  end

  def new
    @user = current_user
    @message = Message.new
    @message.attachments.new
  end

  def show
    @message = Message.find(params[:id])
  end

  def commercial_proposals
    @user = current_user
    @messages = @user.messages.where.not(commercial_proposal: nil).order(created_at: :desc)
  end

  def delivered
    if request.post? && !params['Message-Id'].blank?
      message_id = params['Message-Id'].gsub(/<|>/, '')
      message = Message.find_by_message_id message_id
      message.update delivered_at: Time.current if message.present?
    end
  end

  def opened
    if request.post? && !params['message-id'].blank?
      message_id = params['message-id']
      message = Message.find_by_message_id message_id
      if message.present?
        message.update opened_at: Time.current
        Notification.create(recipient: message.user, actor: message.user, action: 'открыл письмо', notifiable: message, notification_type: 'message')
      end
    end
  end

  def send_mail
    @user = current_user
    @message = Message.new(message_params)
    if params[:attachments_attributes]
      params[:attachments_attributes][:attachment].each do |attachment|
        @message.attachments.build(attachment: attachment)
      end
    end
    respond_to do |format|
      if @message.save
        mail = MessageMailer.send_mail(@message, @user)
        mail.deliver_later

        format.html { redirect_to user_messages_path, notice: "Письмо успешно отправлено на почту: #{@message.to}" }
        format.js do
          case Rails.application.routes.recognize_path(request.referrer)[:controller]
          when 'contacts'
            flash.now[:notice] = "Письмо успешно отправлено на почту: #{@message.to}"
          when 'messages'
            flash.keep[:notice] = "Письмо успешно отправлено на почту: #{@message.to}"
            render js: "window.location = '#{user_messages_path}'"
          end
        end
      else
        format.html { render 'new' }
        format.js do
          @message.attachments.each do |attachment|
            attachment.errors.full_messages.each { |msg| flash.now[:alert] = "Письмо не отправлено. #{msg}" }
          end
        end
      end
    end
  end

  def outbound
    @messages = Message.where(commercial_proposal: nil).where.not(inbound: true).order(created_at: :desc)
    @user = current_user
  end

  private

  def auth_user_before_action
    if request.post? && !params['Message-Id'].blank? || !params['message-id'].blank?
      user = User.where(admin: true).first
      sign_in user, store: false
    end
  end

  def message_params
    params.require(:message).permit(:to, :from, :subject, :body, :user_id, attachments_attributes: [:attachment])
  end
end

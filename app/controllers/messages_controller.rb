class MessagesController < ApplicationController
  protect_from_forgery with: :exception, except: [:delivered]
  prepend_before_action :auth_user_before_action, only: [:delivered]

  def index
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
      message.update delivered_at: Time.current
    end
  end

  private

  def auth_user_before_action
    if request.post? && !params['Message-Id'].blank?
      user = User.first
      sign_in user, store: false
    end
  end

end

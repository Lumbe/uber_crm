class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications_all = Notification.where(recipient: current_user).order(created_at: :desc)

    respond_to do |format|
      format.html
      format.js
    end
  end

  def general_notifications
    @general_notifications = Notification.general.where(recipient: current_user).order(created_at: :desc).first(10)

    respond_to do |format|
      format.html
      format.js
    end
  end

  def message_notifications
    @message_notifications = Notification.message.where(recipient: current_user).order(created_at: :desc).first(10)

    respond_to do |format|
      format.html
      format.js
    end
  end

  def mark_as_read
    if params[:notification_type] == 'general'
      notifications = Notification.general.where(recipient: current_user).unread
      notifications.update_all(read_at: Time.current)
      render json: { success: true }
    elsif params[:notification_type] == 'message'
      notifications = Notification.message.where(recipient: current_user).unread
      notifications.update_all(read_at: Time.current)
      render json: { success: true }
    end
  end
end

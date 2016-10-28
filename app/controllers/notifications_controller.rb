class NotificationsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @user = current_user
    @notifications = Notification.where(recipient: @user).order(created_at: :desc).first(10)
    
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def mark_as_read
    @notifications = Notification.where(recipient: current_user).unread
    @notifications.update_all(read_at: Time.zone.now)
    render json: {success: true}
  end
  
end

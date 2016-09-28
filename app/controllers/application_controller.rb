class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :notification_counter
  
  def notification_counter
    @unread_notifications = Notification.where(recipient: current_user).unread
  end
end

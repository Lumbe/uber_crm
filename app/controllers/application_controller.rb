class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :notification_counter
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to :unauthorized, :alert => exception.message
  end
  
  def notification_counter
    @unread_notifications = Notification.where(recipient: current_user).unread
  end
  
  def unauthorized
    render :unauthorized
  end
end

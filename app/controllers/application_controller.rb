class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :notification_counter
  before_filter :initialize_department
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to :unauthorized, :alert => exception.message
  end
  
  def initialize_department
    unless current_user.nil?
      @user_departments = current_user.departments.uniq
      if current_user.current_department_id.nil?
        current_user.update_attributes(current_department_id: @user_departments.first.id)
        current_user.update_attributes(current_role: Membership.where(department_id: @user_departments.first.id, user_id: current_user.id).first.role)
      end
      if params.has_key?(:current_department_id)
        current_user.update_attributes(current_department_id: params[:current_department_id])
        current_user.update_attributes(current_role: Membership.where(department_id: current_user.current_department_id, user_id: current_user.id).first.role)
        redirect_back(fallback_location: root_path)
      end
    end
  end

  def notification_counter
    @unread_notifications = Notification.where(recipient: current_user).unread
  end
  
  def unauthorized
    render :unauthorized
  end
end

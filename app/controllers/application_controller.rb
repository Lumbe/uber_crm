class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :notification_counter
  before_filter :initialize_department, :initialize_user_role
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to :unauthorized, :alert => exception.message
  end
  
  def initialize_department
    unless current_user.nil?
      @departments = current_user.departments.uniq
      Department.current ||= @departments.first
      if params.has_key?(:department_id)
        Department.current = Department.find(params[:department_id]) 
        redirect_to :back
      end
    end
  end

  def initialize_user_role
    unless current_user.nil? || Department.current.nil? 
      User.current_role = Membership.where(department_id: Department.current.id, user_id: current_user.id).first.role
    end
  end
  
  def notification_counter
    @unread_notifications = Notification.where(recipient: current_user).unread
  end
  
  def unauthorized
    render :unauthorized
  end
end

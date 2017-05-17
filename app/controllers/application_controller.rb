class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include PublicActivity::StoreController
  before_action :authenticate_user!
  before_action :notification_counter
  before_action :initialize_department
  before_action :set_raven_context
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to :unauthorized, alert: exception.message
  end

  def initialize_department
    unless current_user.nil?
      @user_departments = current_user.departments.uniq
      if current_user.current_department_id.nil?
        current_user.update_attributes(current_department_id: @user_departments.first.id)
        current_user.update_attributes(current_role: Membership.where(department_id: @user_departments.first.id, user_id: current_user.id).first.role)
      end
      if params.key?(:current_department_id)
        current_user.update_attributes(current_department_id: params[:current_department_id])
        current_user.update_attributes(current_role: Membership.where(department_id: current_user.current_department_id, user_id: current_user.id).first.role)
        redirect_to root_path
      end
    end
  end

  def notification_counter
    @unread_general_notifications = Notification.general.where(recipient: current_user).unread
    @unread_message_notifications = Notification.message.where(recipient: current_user).unread
  end

  def unauthorized
    render :unauthorized
  end

  private

  def set_raven_context
    # Raven.user_context(id: session["warden.user.user.key"][0][0])
    Raven.extra_context(params: params.to_unsafe_h, url: request.url)
  end
end

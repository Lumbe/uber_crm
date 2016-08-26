class Admin::AdminController < ApplicationController
  
  def index
  end
  
  def dashboard
    @departments = Department.all
  end
  
  def become
    return unless current_user.admin?
    sign_in(:user, User.find(params[:id]))
    redirect_to root_url # or user_root_url
  end
  
  def show
    
  end
  
end

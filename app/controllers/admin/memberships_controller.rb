class Admin::MembershipsController < ApplicationController
  before_action :load_department
  before_action :load_membership, :except => [:new, :create, :index, :edit]
  before_action :load_roles
  load_and_authorize_resource
  
  def new
    @membership = @department.memberships.new
    @users = User.all.collect {|p| [ p.first_name + ' ' + p.last_name, p.id ] }
  end

  def create
    @membership = @department.memberships.new(membership_params)
    
    if @membership.save
      flash[:notice] = "Пользователь #{@membership.user.first_name} #{@membership.user.last_name} успешно добавлен в отдел #{@membership.department.name} (роль: #{@membership.role})"
      redirect_to admin_department_memberships_path
    else
      render 'new'
    end
  end

  def update
    if @membership.update(membership_params)
      flash[:notice] = "Роль пользователя #{@membership.user.first_name} #{@membership.user.last_name} изменена на #{@membership.role}"
      redirect_to :back
    else
      flash.now[:alert] = "Роль пользователя #{@membership.user.first_name} #{@membership.user.last_name} не изменена."
      render 'edit_membership'
    end
  end
  
  private
  
  def membership_params
    params.require(:membership).permit(:user_id, :department_id, :role)
  end
  
  def load_department
    @department = Department.find(params[:department_id])
  end
  
  def load_membership
    @membership = Membership.find(params[:id])
  end
  
  def load_roles
    @roles = Membership.roles.keys
  end
end

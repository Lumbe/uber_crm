class Admin::DepartmentsController < ApplicationController
  def index
    @departments = Department.all.order(created_at: :asc)
  end

  def show
  end

  def new
    @department = Department.new
  end
  
  def create
    @department = Department.new(department_params)

    if @department.save
      redirect_to admin_departments_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
  end

  def destroy
    @department = Department.find(params[:id])
    @department.destroy

    redirect_to admin_departments_path
  end
  
  def new_membership
    @membership = Membership.new
    @roles = Membership.roles.keys
    @department = Department.find(params[:id])
    @users = User.all.collect {|p| [ p.first_name + " " + p.last_name, p.id ] }
  end
  
  def add_membership
    @membership = Membership.new(membership_params)
    
    if @membership.save
      flash[:notice] = "Пользователь #{@membership.user.first_name} #{@membership.user.last_name} успешно добавлен в отдел #{@membership.department.name} (роль: #{@membership.role})"
      redirect_to admin_departments_path
    else
      render 'new_membership'
    end
  end
  
  private
  
  def department_params
    params.require(:department).permit(:name)
  end
  
  def membership_params
    params.require(:membership).permit(:user_id, :department_id, :role)
  end
end

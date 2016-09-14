class Admin::DepartmentsController < ApplicationController
  def index
    @departments = Department.all.order(created_at: :asc)
  end

  def show
    @department = Department.find(params[:id])
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
    @department = Department.find(params[:id])
  end

  def update
    @department = Department.find(params[:id])

    if @department.update(department_params)
      redirect_to admin_department_url(@department)
    else
      render 'edit'
    end
  end

  def destroy
    @department = Department.find(params[:id])
    @department.destroy

    redirect_to admin_departments_path
  end
  
  def retire_user
    @membership = Membership.find(params[:retire_membership_id])
    @membership.retired!
    
    redirect_to :back
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
  
  def edit_membership
    @department = Department.find(params[:id])
    @roles = Membership.roles.keys
  end
  
  def update_membership
    @department = Department.find(params[:id])
    @membership = Membership.find(params[:membership_id])
    @roles = Membership.roles.keys

    if @membership.update(membership_params)
      flash[:notice] = "Роль пользователя #{@membership.user.first_name} #{@membership.user.last_name} изменена на #{@membership.role}"
      redirect_to :back
    else
      flash.now[:alert] = "Роль пользователя #{@membership.user.first_name} #{@membership.user.last_name} не изменена."
      render 'edit_membership'
    end
  end

  private
  
  def department_params
    params.require(:department).permit(:name, :avatar)
  end
  
  def membership_params
    params.require(:membership).permit(:user_id, :department_id, :role)
  end
end

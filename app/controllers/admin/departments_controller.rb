class Admin::DepartmentsController < ApplicationController
  load_and_authorize_resource

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

  private

  def department_params
    params.require(:department).permit(:name, :avatar, :city, :address, :facebook, :vkontakte, :website, :email)
  end

end

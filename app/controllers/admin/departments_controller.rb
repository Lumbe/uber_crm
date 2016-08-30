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
  
  private
  
  def department_params
    params.require(:department).permit(:name)
  end
end

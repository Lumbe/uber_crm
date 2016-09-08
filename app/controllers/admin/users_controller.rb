class Admin::UsersController < ApplicationController
  def index
    @users = User.all.order(created_at: :asc)
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to admin_users_path
    else
      render 'new'
    end
  end

  def update
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to admin_users_path
  end
  
  def become
    return unless current_user.admin?
    sign_in(:user, User.find(params[:id]))
    redirect_to root_url # or user_root_url
  end
  
  def departments
    @user = User.find(params[:id])
    @memberships = @user.memberships.order(created_at: :asc)
  end
  
  def profile
    @user = User.find(params[:id])
    @memberships = @user.memberships.order(created_at: :asc)
  end
  
  def settings
    @user = User.find(params[:id])
    @memberships = @user.memberships.order(created_at: :asc)
  end
  
  private
  
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :avatar)
  end
end

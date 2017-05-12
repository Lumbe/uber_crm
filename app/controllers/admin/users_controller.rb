class Admin::UsersController < ApplicationController
  load_and_authorize_resource

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

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :avatar, :phone, :skype)
  end
end

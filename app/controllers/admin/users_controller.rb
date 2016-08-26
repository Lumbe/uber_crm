class Admin::UsersController < ApplicationController
  def index
    @users = User.all.order(created_at: :asc)
  end

  def show
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
  end
  
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end
end

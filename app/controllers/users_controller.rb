class UsersController < ApplicationController
  
  def index
    
  end
  
  def show
    @user = User.find(params[:id])
    @memberships = @user.memberships.order(created_at: :asc)
  end
  
  def edit
    
  end
  
  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to @user
    else
      render 'settings'
    end
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

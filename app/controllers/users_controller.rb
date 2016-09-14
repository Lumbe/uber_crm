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
  
end

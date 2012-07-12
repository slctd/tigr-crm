class Admin::UsersController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  
  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
    
    # Log recent items
    @user.recent_items.create(user_id: current_user.id)
  end  
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    
    if @user.save
      redirect_to admin_users_url, notice: "User was created."
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])

    if @user.update_without_password(params[:user])
      redirect_to admin_users_url, notice: "User was updated"
    else
      render 'edit'
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_url
  end
end
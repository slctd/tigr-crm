class UsersController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  
  def profile
    @recent_tasks = Task.where(responsible_id: current_user)
    @recent_deals = Deal.where(responsible_id: current_user)
    @user_objects = @recent_tasks + @recent_deals
    @recent_actions = current_user.recent_actions.days
  end
  
  def edit
    @user = current_user
  end
  
  def update
    @user = current_user

    if @user.update_without_password(params[:user])
      redirect_to profile_url, notice: "Your profile was updated."
    else
      render 'edit'
    end
  end
end

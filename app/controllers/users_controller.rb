class UsersController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  
  def profile
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

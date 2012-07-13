class AuthenticationsController < ApplicationController
  def create
    omniauth = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    if authentication
      # Sign in existing user that have already added the provider
      flash[:notice] = "Signed in successfully."
      sign_in_and_redirect(:user, authentication.user)
    elsif current_user
      # Add new provider for signed in user
      current_user.authentications.create(:provider => omniauth['provider'], :uid => omniauth['uid'])
      flash[:notice] = "Authentication successful."
      redirect_to profile_url
    else
      # User isn't signed in and there is no any user with this provider and uid
      # We should restrict access for him
      flash[:error] = "Authentication error."
      redirect_to new_user_session_url
    end
  end
  
  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    flash[:notice] = "Successfully destroyed authentication."
    redirect_to profile_url
  end
  
  protected
    # This is necessary since Rails 3.0.4
    # See https://github.com/intridea/omniauth/issues/185
    # and http://www.arailsdemo.com/posts/44
    def handle_unverified_request
      true
    end
end
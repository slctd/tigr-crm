class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :set_i18n_locale_from_params
  before_filter :set_current_user
  
  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = "You have no permission to access this page."
    redirect_to root_url
  end
  
  def set_current_user
    User.current = current_user
  end

  private

    def set_i18n_locale_from_params
      if params[:locale]
        if I18n.available_locales.include?(params[:locale].to_sym)
          I18n.locale = params[:locale]
        else
          flash.now[:notice] = "#{params[:locale]} translation not available"
        end
      end
    end
    
    def default_url_options
      { locale: I18n.locale}
    end
end

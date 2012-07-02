class PagesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource class: PagesController
  
  def index
  end
end

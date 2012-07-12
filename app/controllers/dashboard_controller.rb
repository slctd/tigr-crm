class DashboardController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource class: DashboardController
  
  def index
    @recent_actions = RecentAction.order("created_at desc").limit(100)
  end
end
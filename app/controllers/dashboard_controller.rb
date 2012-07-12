class DashboardController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource class: DashboardController
  
  def index
    @recent_actions = RecentAction.order("created_at desc")
    @recent_actions = @recent_actions.by_action_type(params[:action_type]) if params[:action_type].present?
    @recent_actions = @recent_actions.by_user(params[:user]) if params[:user].present?
    case params[:date]
      when I18n.t("dashboard.index.days") then @recent_actions = @recent_actions.days
      when I18n.t("dashboard.index.weeks") then @recent_actions = @recent_actions.weeks
      when I18n.t("dashboard.index.months") then @recent_actions = @recent_actions.months
      else @recent_actions = @recent_actions.days
    end
  end
end
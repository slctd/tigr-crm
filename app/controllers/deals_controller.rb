class DealsController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @deals = Deal.all
  end
end
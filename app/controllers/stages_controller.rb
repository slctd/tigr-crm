class StagesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  
  def show
    @stage = Stage.find(params[:id])
    respond_to do |format|
      format.json { render json: @stage }
    end
  end
end

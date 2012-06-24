class StagesController < ApplicationController
  def show
    @stage = Stage.find(params[:id])
    respond_to do |format|
      format.json { render json: @stage }
    end
  end
end

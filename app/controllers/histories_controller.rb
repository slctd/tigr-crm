class HistoriesController < ApplicationController
  def create
    @history = current_user.histories.new(params[:history])
    flash[:error] = "History wasn't added" unless @history.save
    redirect_to historable_url(@history)
  end
  
  def destroy
    
  end
  
  private
  
    def historable_url(history)
      unless history.historable.nil?
        url = company_url(history.historable, anchor: "histories") if history.historable_type == "Company"
        url = person_url(history.historable, anchor: "histories") if history.historable_type == "Person"
      else
        url = deal_url(Deal.find(params[:deal_id]), anchor: "histories") if params[:deal_id].present?
        url = event_url(Event.find(params[:event_id]), anchor: "histories") if params[:event_id].present?
      end
      url
    end
end
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
        url = deal_url(history.deal, anchor: "histories")
      end
      url
    end
end
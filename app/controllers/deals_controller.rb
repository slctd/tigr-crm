class DealsController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @deals = Deal.all
  end
  
  def new
    @deal = Deal.new
    if params[:company_id].present?
      @deal.dealable = Company.find(params[:company_id])
    end
    if params[:person_id].present?
      @deal.dealable = Person.find(params[:person_id])
    end    
  end
  
  def create
    @deal = Deal.new(params[:deal])
    
    if @deal.save
      redirect_to deal_or_dealable_url(@deal), notice: 'Deal was successfully created.'
    else
      render "new"
    end  
  end

  private

    def deal_or_dealable_url(deal)
      if deal.dealable.nil?
        deals_url
      else
        polymorphic_url(deal.dealable, anchor: "deals")
      end
    end
end
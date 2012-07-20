require "#{Rails.root}/lib/importer"

class DealsController < ApplicationController

  include Importer

  before_filter :authenticate_user!
  load_and_authorize_resource
  
  def index
    @deals = Deal.order(:closing_date)
       
    if params[:by_name].present?
      @deals = @deals.by_name(params[:by_name])
    end
  end
  
  def show
    @deal = Deal.find(params[:id])
    @history = History.new
    @history.deal = @deal
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
  
  def edit
    @deal = Deal.find(params[:id])
  end
  
  def create
    @deal = Deal.new(params[:deal])
    
    if @deal.save
      redirect_to @deal, notice: 'Deal was successfully created.'
    else
      render "new"
    end  
  end
  
  def update
    @deal = Deal.find(params[:id])

    if @deal.update_attributes(params[:deal])
      redirect_to @deal, notice: 'Deal was successfully updated.'
    else
      render "edit"
    end
  end
  
  def add_participant
    @deal = Deal.find(params[:deal_id])
    @deal.add_participant(params[:participant])
    redirect_to deal_path(@deal, anchor: "participants")
  end
  
  def remove_participant
    @deal = Deal.find(params[:deal_id])
    participant = "#{params[:participant_id]}_#{params[:participant_type]}"
    @deal.remove_participant(participant)
    redirect_to deal_path(@deal, anchor: "participants")
  end
end
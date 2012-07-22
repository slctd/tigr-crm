require "#{Rails.root}/lib/importer"

class EventsController < ApplicationController

  include Importer
  
  before_filter :authenticate_user!
  load_and_authorize_resource
  
  def index
    @events = Event.order(:name)
    
    if params[:by_name].present?
      @events = @events.by_name(params[:by_name])
    end

    respond_to do |format|
      format.html
      format.csv { render text: Event.to_csv }
    end
  end
  
  def show
    @event = Event.find(params[:id])
    @history = History.new
    @history.event = @event
  end
  
  def new
    @event = Event.new
  end
  
  def create
    @event = Event.new(params[:event])
    
    if @event.save
      redirect_to @event, notice: 'Event was successfully created.'
    else
      render "new"
    end  
  end
  
  def edit
    @event = Event.find(params[:id])
  end
  
  def update
    @event = Event.find(params[:id])

    if @event.update_attributes(params[:event])
      redirect_to @event, notice: 'Event was successfully updated.'
    else
      render "edit"
    end
  end
  
  def add_participant
    @event = Event.find(params[:event_id])
    @event.add_participant(params[:participant])
    redirect_to event_path(@event, anchor: "participants")
  end
  
  def remove_participant
    @event = Event.find(params[:event_id])
    participant = "#{params[:participant_id]}_#{params[:participant_type]}"
    @event.remove_participant(participant)
    redirect_to event_path(@event, anchor: "participants")
  end
  
  def change_status
    @event = Event.find(params[:event_id])
    @event.toggle!(:opened)
    redirect_to event_path(@event)
  end
end

class EventsController < ApplicationController
  def index
    @events = Event.order(:name)
    
    if params[:by_name].present?
      @events = @events.by_name(params[:by_name])
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
end

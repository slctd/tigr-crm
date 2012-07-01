class TasksController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @tasks = Task.all
  end
  
  def new
    @task = Task.new
    @task.taskable = Company.find(params[:company_id]) if params[:company_id].present?
    @task.taskable = Person.find(params[:person_id]) if params[:person_id].present?
    @task.deal_id = params[:deal_id] if params[:deal_id].present?
    @task.event_id = params[:event_id] if params[:event_id].present?
  end
  
  def create
    @task = Task.new(params[:task])
    
    if @task.save
      redirect_to task_or_taskable_url(@task), notice: 'Task was successfully created.'
    else
      render "new"
    end
  end
  
  def edit
    @task = Task.find(params[:id])
  end
  
  def update
    @task = Task.find(params[:id])

    if @task.update_attributes(params[:task])
      redirect_to task_or_taskable_url(@task), notice: 'Task was successfully updated.'
    else
      render "edit"
    end
  end
  
  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    redirect_to task_or_taskable_url(@task), notice: 'Task was deleted.'
  end
  
  private

    def task_or_taskable_url(task)
      if task.taskable.nil?
        url = tasks_url
      else
        url = polymorphic_url(task.taskable, anchor: "tasks")
      end
      
      url = deal_url(task.deal, anchor: "tasks") unless task.deal_id.nil?
      url = event_url(task.event, anchor: "tasks") unless task.event_id.nil?
      
      url
    end
end

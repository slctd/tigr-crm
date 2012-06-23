class TasksController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @tasks = Task.all
  end
  
  def new
    @task = Task.new
    if params[:company_id].present?
      @task.taskable = Company.find(params[:company_id])
    end
    if params[:person_id].present?
      @task.taskable = Person.find(params[:person_id])
    end
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
        tasks_url
      else
        polymorphic_url(task.taskable, anchor: "tasks")
      end
    end
end

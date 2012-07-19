class TasksController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
    @tasks = Task.order("deadline_date desc")

    if params[:by_name].present?
      @tasks = @tasks.by_name(params[:by_name])
    end
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

  def import_step_1
    # Show select file form
  end

  def import_step_2
    # Save CSV file to database
    # and select columns to import
    file = params[:file]
    begin
      ActiveRecord::Base.transaction do
        @import = Import.new(Task)

        CSV.foreach(file.tempfile, {:headers => true}) do |row|
          next if row.to_s.parse_csv.join.blank? # Skip blank row

          import_row = @import.import_table.import_rows.create
          
          row.each do |cell|
            import_row.import_cells.create(
              header: cell[0].to_s.force_encoding('utf-8') || "",
              data: cell[1].to_s.force_encoding('utf-8') || ""
            )
          end
        end
      end
    rescue ActiveRecord::RecordInvalid => e
      flash[:error] = t('import.errors.general.error')
      redirect_to tasks_import_step_1_path
      return
    end
  end

  def import_step_3
    @import = Import.new(Task, params[:import_table], columns: params[:columns])
   
    if @import.save?
      redirect_to tasks_path, notice: t('import.complete')
    else
      render 'import_step_2'
    end
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

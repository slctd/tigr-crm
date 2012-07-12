class PeopleController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
    @people = Person.free.order(:firstname).where("firstname like ? or lastname like ?", "%#{params[:q]}%", "%#{params[:q]}%")
    render json: @people.to_json(methods: [:name], only: [:id])
  end
  
  def show
    @person = Person.find(params[:id])
    @history = History.new
    @history.contact = "#{@person.id}_Person"
    
    # Log recent items
    @person.recent_items.create(user_id: current_user.id)
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @person }
    end
  end
  
  def new
    @person = Person.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @person }
    end
  end

  def edit
    @person = Person.find(params[:id])
  end  
  
  def create
    @person = Person.new(params[:person])

    respond_to do |format|
      if @person.save
        format.html { redirect_to @person, notice: 'Person was successfully created.' }
        format.json { render json: @person, status: :created, location: @person }
      else
        format.html { render action: "new" }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end  
  
  def update
    @person = Person.find(params[:id])
    
    # Nil company if empty name
    @person.company = nil if params[:person][:company_name] == ''
    
    respond_to do |format|
      if @person.update_attributes(params[:person])
        format.html { redirect_to @person, notice: 'Person was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end  
  
  def destroy
    @person = Person.find(params[:id])
    @person.destroy

    respond_to do |format|
      format.html { redirect_to contacts_url }
      format.json { head :no_content }
    end
  end
end

class PeopleController < ApplicationController
  before_filter :authenticate_user!

  def show
    @person = Person.find(params[:id])

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
  
  def add_to_company
      @person = Person.find(params[:person_id])
      @company = Company.find(params[:company_id])

      respond_to do |format|
        if @person.update_attributes(company_id: @company)
          format.html { redirect_to @company, notice: 'Person was successfully added to the company.' }
          format.json { head :no_content }
        else
          format.html { redirect_to @company, error: "Person wasn't added to the company." }
          format.json { render json: @person.errors, status: :unprocessable_entity }
        end
      end
  end
end

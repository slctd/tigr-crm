class SearchController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource class: SearchController
  
  def index
    
    # Find companies
    @companies = Company.by_name(params[:search]).order(:name)
    # Remember thier count
    companies_count = @companies.count
    # Remove all but 10 companies to show
    @companies = @companies.limit(10)

    # The same logic for people, tasks, deals and events
    @people = Person.by_name(params[:search]).order(:firstname)
    people_count = @people.count

    # Here we should calculate limit for people
    # because people and companies are displayed in one block 'Contacts'
    if companies_count >= 10
      people_limit = 0
    else
      people_limit = 10 - companies_count
    end
    @people = @people.limit(people_limit)

    # Calculate sum of companies and people
    @contacts_count = companies_count + people_count

    @tasks =  Task.by_name(params[:search]).order("deadline_date desc")
    @tasks_count = @tasks.count
    @tasks = @tasks.limit(10)

    @deals =  Deal.by_name(params[:search]).order(:closing_date)
    @deals_count = @deals.count
    @deals = @deals.limit(10)

    @events = Event.by_name(params[:search]).order(:name)
    @events_count = @events.count
    @events = @events.limit(10)
  end
end
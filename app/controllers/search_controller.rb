class SearchController < ApplicationController
  def index
    # Search in companies
    @companies = Company.where("name like ?", "%#{params[:search]}%")
    @people = Person.where("firstname like ? or lastname like ?", "%#{params[:search]}%", "%#{params[:search]}%")
    @tasks =  Task.where("name like ?", "%#{params[:search]}%") + 
              Task.where("description like ?", "%#{params[:search]}%")
    @deals =  Deal.where("name like ?", "%#{params[:search]}%") + 
              Deal.where("description like ?", "%#{params[:search]}%")
    @events = Event.where("name like ?", "%#{params[:search]}%")
  end
end

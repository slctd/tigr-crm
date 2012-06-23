class ContactsController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @companies = Company.order(:name)
    @people = Person.order(:firstname)
    @contacts = @companies.where("name like ?", "%#{params[:q]}%") +
                @people.where("firstname like ? or lastname like ?", "%#{params[:q]}%", "%#{params[:q]}%")
    respond_to do |format|
      format.html
      format.json { render }
    end
  end
end
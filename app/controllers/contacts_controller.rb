class ContactsController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @companies = Company.all
    @people = Person.all
  end
end

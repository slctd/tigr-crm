require "#{Rails.root}/lib/importer"

class ContactsController < ApplicationController
  
  include Importer

  before_filter :authenticate_user!
  load_and_authorize_resource class: ContactsController
  
  def index
    @companies = Company.order(:name)
    @people = Person.order(:firstname)
    
    if params[:by_name].present?
      @companies = @companies.by_name(params[:by_name])
      @people = @people.by_name(params[:by_name])
    end
    
    @contacts = @companies.where("name like ?", "%#{params[:q]}%") +
                @people.where("firstname like ? or lastname like ?", "%#{params[:q]}%", "%#{params[:q]}%")

    respond_to do |format|
      format.html
      format.json { render }
      format.csv { render text: Contact.to_csv }
    end
  end
end
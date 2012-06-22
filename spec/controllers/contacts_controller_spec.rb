require 'spec_helper'

describe ContactsController do

    describe "GET index" do
    before(:each) do
      sign_in FactoryGirl.create(:user)      
    end
      
    it "assigns all companies as @companies" do
      company = FactoryGirl.create(:company)
      get :index
      assigns(:companies).should eq([company])
    end
    
    it "assigns all people as @people" do
      person = FactoryGirl.create(:person)
      get :index
      assigns(:people).should eq([person])
    end    
  end
  
end

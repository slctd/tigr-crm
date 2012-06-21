require 'spec_helper'

describe ContactsController do

    describe "GET index" do
    it "assigns all companies as @companies" do
      sign_in FactoryGirl.create(:user)
      company = FactoryGirl.create(:company)
      get :index
      assigns(:companies).should eq([company])
    end
  end
  
end

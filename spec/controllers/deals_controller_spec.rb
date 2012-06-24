require 'spec_helper'

describe DealsController do
  describe "GET index" do
    describe "unauthorized" do
      it "should redirect to login page" do
        get :index
        response.should redirect_to new_user_session_path
      end
    end
    
    describe "authorized" do
      before(:each) do
        sign_in FactoryGirl.create(:user)
      end
      
      it "should assign all deals" do
        2.times { FactoryGirl.create(:deal) }
        deals = Deal.all
        get :index
        assigns(:deals).should eq(deals)
      end
    end
  end
  
  describe "GET new" do
    describe "unauthorized" do
      it "should redirect to login page" do
        get :new
        response.should redirect_to new_user_session_path
      end
    end
   
    describe "authorized" do
      before(:each) do
        sign_in FactoryGirl.create(:user)
      end
       
      it "should assign new deal" do
        get :new
        assigns(:deal).should be_a_new(Deal)
      end
       
      it "should have a proper contact for nested deal (company)" do
        company = FactoryGirl.create(:company)
        get :new, { company_id: company.id }
        assigns(:deal).should be_a_new(Deal).with(dealable_id: company.id, dealable_type: "Company")
      end
       
      it "should have a proper contact for nested deal (person)" do
        person = FactoryGirl.create(:person)
        get :new, { person_id: person.id }
        assigns(:deal).should be_a_new(Deal).with(dealable_id: person.id, dealable_type: "Person")
      end
    end
  end
end

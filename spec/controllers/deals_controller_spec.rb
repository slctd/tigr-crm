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

  describe "POST create" do
    describe "unauthorized" do
      it "should redirect to login page" do
        post :create, FactoryGirl.attributes_for(:deal)
        response.should redirect_to new_user_session_path
      end
    end
    
    describe "authorized" do
      before(:each) do
        sign_in FactoryGirl.create(:user)
      end
      
      it "should create a new deal" do
        expect {
          post :create, {:deal => FactoryGirl.attributes_for(:deal)}
        }.to change(Deal, :count).by(1)
      end
      
      describe "with valid params" do
        it "redirects to the deals url for independent deal" do
          post :create, {:deal => FactoryGirl.attributes_for(:deal)}
          response.should redirect_to deals_url
        end
        
        it "redirects to the company for nested deal" do
          company = FactoryGirl.create(:company)
          post :create, {:deal => FactoryGirl.attributes_for(:deal, contact: company.id.to_s + "_Company") }
          response.should redirect_to company_url(company, anchor: "deals")
        end
        
        it "redirects to the person for nested deal" do
          person = FactoryGirl.create(:person)
          post :create, {:deal => FactoryGirl.attributes_for(:deal, contact: person.id.to_s + "_Person") }
          response.should redirect_to person_url(person, anchor: "deals")
        end     
      end
      
      describe "with invalid params" do
        it "assigns a newly created but unsaved deal as @deal" do
          # Trigger the behavior that occurs when invalid params are submitted
          Deal.any_instance.stub(:save).and_return(false)
          post :create, {:deal => {}}
          assigns(:deal).should be_a_new(Deal)
        end
  
        it "re-renders the 'new' template" do
          # Trigger the behavior that occurs when invalid params are submitted
          Deal.any_instance.stub(:save).and_return(false)
          post :create, {:deal => {}}
          response.should render_template("new")
        end
      end
    end
  end
end

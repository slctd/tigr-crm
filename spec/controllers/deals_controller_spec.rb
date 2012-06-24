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
end

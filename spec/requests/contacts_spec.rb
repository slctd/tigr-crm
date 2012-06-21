require 'spec_helper'

describe "Contacts" do
  describe "GET /contacts" do
    it "redirects to sign in page if user isn't logged in" do
      get contacts_path
      response.should redirect_to new_user_session_url
    end
    
    it "shows list of companies and persons" do
#      user = FactoryGirl.create(:user)
#      company = FactoryGirl.create(:company)
#      integration_sign_in FactoryGirl.create(:user)
#      visit companies_path
#      page.should have_content company.name
    end    
  end
end

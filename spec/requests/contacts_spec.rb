require 'spec_helper'

describe "Contacts" do
  describe "GET /contacts" do
    it "redirects to sign in page if user isn't logged in" do
      get contacts_path
      response.should redirect_to new_user_session_url
    end
    
    it "shows list of companies and persons" do
      user = FactoryGirl.create(:user)
      company = FactoryGirl.create(:company)
      person = FactoryGirl.create(:person)
      
      integration_sign_in FactoryGirl.create(:user)
      visit contacts_path

      page.should have_selector("td", text: company.name)
      page.should have_selector("td", text: "#{person.firstname} #{person.lastname}")
    end    
  end
end

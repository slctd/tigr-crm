require 'spec_helper'

describe "People" do
  before(:each) do
    integration_sign_in FactoryGirl.create(:user)
  end
  
  describe "/people/:id" do
    pending "something for show action"
    
    it "opens tasks tab when #tasks path open" do
      person = FactoryGirl.create(:person)
      visit person_path(person, anchor: "tasks")
      page.should have_selector('a', content: "New task", visible: false)
    end
  end
  
  describe "/person/new" do
    it "creates a new company if it's name typed" do
      new_company_name = FactoryGirl.generate(:random_string)
      visit new_person_path
      fill_in "person[firstname]", with: "Firstname"
      fill_in "person[lastname]", with: "Lastname"
      fill_in "person[company_name]", with: new_company_name
      lambda do
        click_button :commit
      end.should change(Company, :count).by(1)
      Company.last.name.should == new_company_name
    end
  end
end

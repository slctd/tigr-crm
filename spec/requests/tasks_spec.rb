require 'spec_helper'

describe "Tasks" do
  describe "GET /tasks" do
    before(:each) do
      integration_sign_in FactoryGirl.create(:user)
    end
    
    it "shows list of tasks" do
      company_task = FactoryGirl.create(:company).tasks.create!(FactoryGirl.attributes_for(:task))
      person_task = FactoryGirl.create(:person).tasks.create!(FactoryGirl.attributes_for(:task))
      visit tasks_path
      page.should have_selector("td", text: company_task.name)
      page.should have_selector("td", text: company_task.description)    
      page.should have_selector("td", text: company_task.deadline_date.to_date.to_s)
      page.should have_selector("td", text: person_task.name)      
      page.should have_selector("td", text: person_task.description)            
      page.should have_selector("td", text: person_task.deadline_date.to_date.to_s)      
    end
  end
end

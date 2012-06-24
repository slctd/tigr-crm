# encoding: utf-8
require 'spec_helper'

describe "Deals" do
  before(:each) do
    integration_sign_in FactoryGirl.create(:user)
  end
  
  describe "GET /deals" do
    before(:each) do
      @deal1 = FactoryGirl.create(:deal_by_company, budget: nil)
      @deal2 = FactoryGirl.create(:deal_by_person, budget: nil)
      @deal3 = FactoryGirl.create(:deal)
      visit deals_path
    end
    
    it "shows names of deals" do
      page.should have_selector("td", text: @deal1.name)
      page.should have_selector("td", text: @deal2.name)
      page.should have_selector("td", text: @deal3.name)
    end
    
    it "shows contact link for each deal" do
      deal_tr1 = find("tr", text: @deal1.name)
      deal_tr1.should have_selector("a",  href: company_path(@deal1.dealable), 
                                          text: @deal1.dealable.name)
      deal_tr2 = find("tr", text: @deal2.name)
      deal_tr2.should have_selector("a",  href: person_path(@deal2.dealable), 
                                          text: @deal2.dealable.name)
      deal_tr3 = find("tr", text: @deal3.name)
      deal_tr3.should have_selector("td", text: "Клиент не задан")
    end
    
    it "shows responsible user's email" do
      page.should have_selector("td", text: @deal1.responsible.email)
      page.should have_selector("td", text: @deal2.responsible.email)
      page.should have_selector("td", text: @deal3.responsible.email)
    end
    
    it "shows properly budget of deals" do
      find("tr", text: @deal1.name).should_not have_selector("td", text: "#{@deal1.budget.to_s} #{@deal1.currency.abbreviation}")
      find("tr", text: @deal2.name).should_not have_selector("td", text: "#{@deal1.budget.to_s} #{@deal2.currency.abbreviation}")
      find("tr", text: @deal3.name).should have_selector("td", text: "#{@deal3.budget.to_s} #{@deal3.currency.abbreviation}")
    end
  end
end

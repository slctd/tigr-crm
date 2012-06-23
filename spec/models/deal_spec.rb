require 'spec_helper'

describe Deal do
  it "should have a name" do
    FactoryGirl.build(:deal, name: nil).should be_invalid
  end
  
  it "should respond to currency" do
    FactoryGirl.create(:deal).should respond_to(:currency)
  end
  
  it "should have budget more than 0" do
    FactoryGirl.build(:deal, budget: -1).should be_invalid
  end
  
  it "should have no budget" do
    FactoryGirl.build(:deal, budget: nil).should be_valid
  end
  
  it "should respond to budget_type" do
    FactoryGirl.create(:deal).should respond_to(:budget_type)
  end
  
  it "should respond to stage" do
    FactoryGirl.create(:deal).should respond_to(:stage)
  end
  
  it "should have success probability > 0" do
    deal = FactoryGirl.create(:deal, success_probability: -1)
    deal.reload
    deal.success_probability.should == 0
  end
  
  it "should have success probability < 100" do
    deal = FactoryGirl.create(:deal, success_probability: 101)
    deal.reload
    deal.success_probability.should == 100
  end
  
  it "should set success probability to 0 when it's nil" do
    deal = FactoryGirl.create(:deal, success_probability: nil)
    deal.reload
    deal.success_probability.should == 0
  end
  
  describe "taskable association" do
    it "should respond to dealable" do
      FactoryGirl.create(:deal_by_company).should respond_to(:dealable)
      FactoryGirl.create(:deal_by_person).should respond_to(:dealable)      
    end
    
    it "should be created with contact line by company" do
      company = FactoryGirl.create(:company)
      deal = FactoryGirl.create(:deal, contact: "#{company.id}_Company")
      deal.dealable.should == company
    end

    it "should be created with contact line by person" do
      person = FactoryGirl.create(:person)
      deal = FactoryGirl.create(:deal, contact: "#{person.id}_Person")
      deal.dealable.should == person
    end
  end
end

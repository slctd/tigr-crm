require 'spec_helper'

describe Task do
  it "should be created by company" do
    company =  FactoryGirl.create(:company)
    task = company.tasks.new(FactoryGirl.attributes_for(:task))
    task.should be_valid
  end
  
  it "should be created by person" do
    person =  FactoryGirl.create(:person)
    task = person.tasks.new(FactoryGirl.attributes_for(:task))
    task.should be_valid
  end
  
  it "should not be created by itself" do
    task = Task.new(FactoryGirl.attributes_for(:task))
    task.should be_invalid
  end
end

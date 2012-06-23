require 'spec_helper'

describe Task do
  it "should be created by company" do
    task = Task.new(FactoryGirl.attributes_for(:task))
    task.taskable_id = FactoryGirl.create(:company).id
    task.taskable_type = "Company"
    task.should be_valid
  end
  
  it "should be created by person" do
    task = Task.new(FactoryGirl.attributes_for(:task))
    task.taskable_id = FactoryGirl.create(:person).id
    task.taskable_type = "Person"
    task.should be_valid
  end
  
  it "should be created by no one" do
    task = Task.new(FactoryGirl.attributes_for(:task))
    task.should be_valid
  end
end

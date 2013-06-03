# == Schema Information
#
# Table name: tasks
#
#  id            :integer          not null, primary key
#  taskable_id   :integer
#  taskable_type :string(255)
#  event_id      :integer
#  deal_id       :integer
#  name          :string(255)
#  task_type_id  :integer
#  description   :text(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  deadline_date :date
#  user_id       :integer
#

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

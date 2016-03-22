# == Schema Information
#
# Table name: stages
#
#  id                  :integer          not null, primary key
#  name                :string(255)
#  success_probability :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

require 'spec_helper'

describe Stage do
  it "should have unique names" do
    stage1 = FactoryGirl.create(:stage)
    stage2 = FactoryGirl.build(:stage, name: stage1.name)
    stage2.should be_invalid
  end
  
  it "should have success probability > 0" do
    stage = FactoryGirl.create(:stage, success_probability: -1)
    stage.reload
    stage.success_probability.should == 0
  end
  
  it "should have success probability < 100" do
    stage = FactoryGirl.create(:stage, success_probability: 101)
    stage.reload
    stage.success_probability.should == 100
  end
  
  it "should set success probability to 0 when it's nil" do
    stage = FactoryGirl.create(:stage, success_probability: nil)
    stage.reload
    stage.success_probability.should == 0
  end
end

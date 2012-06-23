require 'spec_helper'

describe Stage do
  it "should have unique names" do
    stage1 = Stage.create!(name: "stage", success_probability: 100)
    stage2 = Stage.new(name: "stage", success_probability: 100)
    stage2.should be_invalid
  end
  
  it "should have success probability > 0" do
    stage = Stage.create!(name: "stage", success_probability: -1)
    stage.reload
    stage.success_probability.should == 0
  end
  
  it "should have success probability < 100" do
    stage = Stage.create!(name: "stage", success_probability: 101)
    stage.reload
    stage.success_probability.should == 100
  end
end

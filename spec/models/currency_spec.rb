require 'spec_helper'

describe Currency do
  it "should have a name" do
    Currency.new(abbreviation: "RUB").should be_invalid    
  end
  
  it "should have an abbreviation" do
    Currency.new(name: "dollar").should be_invalid    
  end  
end

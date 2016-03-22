# == Schema Information
#
# Table name: currencies
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  abbreviation :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'spec_helper'

describe Currency do
  it "should have a name" do
    Currency.new(abbreviation: "RUB").should be_invalid    
  end
  
  it "should have an abbreviation" do
    Currency.new(name: "dollar").should be_invalid    
  end  
end

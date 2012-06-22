require 'spec_helper'

describe "People" do
  before(:each) do
    integration_sign_in FactoryGirl.create(:user)
  end
  
  describe "/person/:id" do
    pending "something for show action"
  end
end

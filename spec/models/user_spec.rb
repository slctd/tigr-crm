require 'spec_helper'

describe User do
  it " should reject users with the same emails" do
    email = FactoryGirl.generate(:email)
    user1 = User.create!(email: email)
    user2 = User.new(email: email)
    user2.should be_invalid
  end
end

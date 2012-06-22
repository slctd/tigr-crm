require 'spec_helper'

describe Person do
  describe "associations" do
    it "should delete emails when deleted" do
      person = FactoryGirl.create(:person);
      email = person.emails.create!(email: "a@a.a", email_type_id: FactoryGirl.create(:email_type).id)
      email_id = email.id
      person.destroy
      Email.where(id: email_id).first.should == nil
    end
  end
end

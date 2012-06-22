require 'spec_helper'

describe Company do
  describe "associations" do
    it "should delete emails when deleted" do
      company = FactoryGirl.create(:company);
      email = company.emails.create!(email: "a@a.a", email_type_id: FactoryGirl.create(:email_type).id)
      email_id = email.id
      company.destroy
      Email.where(id: email_id).first.should == nil
    end
  end
end

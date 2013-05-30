# == Schema Information
#
# Table name: companies
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  description     :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  contact_type_id :integer
#  image           :string(255)
#

require 'spec_helper'

describe Company do
  
  it "should reject companies with the same names" do
    company1 = FactoryGirl.create(:company, name: "Company 1")
    company2 = Company.new(name: "Company 1")
    company2.should be_invalid
  end
  
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

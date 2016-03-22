# == Schema Information
#
# Table name: people
#
#  id              :integer          not null, primary key
#  firstname       :string(255)
#  lastname        :string(255)
#  company_id      :integer
#  job             :string(255)
#  description     :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  contact_type_id :integer
#  image           :string(255)
#  full_name       :string(255)
#

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

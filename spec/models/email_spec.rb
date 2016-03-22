# == Schema Information
#
# Table name: emails
#
#  id             :integer          not null, primary key
#  email          :string(255)
#  email_type_id  :string(255)
#  emailable_id   :integer
#  emailable_type :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'spec_helper'

describe Email do
  it "should reject invalid emails" do
    wrong_emails = %w"a a@a a@.a"
    email_type = FactoryGirl.create(:email_type)
    company = FactoryGirl.create(:company)
    wrong_emails.each do |wrong_email|
      email = company.emails.new(email: wrong_email, email_type_id: email_type.id)
      email.should_not be_valid
    end
  end
end

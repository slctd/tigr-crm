require 'spec_helper'

describe Email do
  it "should reject invalid emails" do
    wrong_emails = %w"a a@a a@.a"
    email_type = FactoryGirl.create(:email_type)
    wrong_emails.each do |wrong_email|
      email = Email.new(email: wrong_email, email_type_id: email_type.id)
      email.should_not be_valid
    end
  end
end

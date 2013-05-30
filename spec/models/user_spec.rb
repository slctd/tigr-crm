# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  admin                  :boolean          default(FALSE)
#  name                   :string(255)
#  image                  :string(255)
#  gender                 :string(255)
#  birthday               :date
#  comment                :text
#

require 'spec_helper'

describe User do
  it " should reject users with the same emails" do
    email = FactoryGirl.generate(:email)
    user1 = User.create!(email: email)
    user2 = User.new(email: email)
    user2.should be_invalid
  end
end

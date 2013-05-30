# == Schema Information
#
# Table name: user_contacts
#
#  id                   :integer          not null, primary key
#  user_id              :integer
#  user_contact_type_id :integer
#  user_contact         :string(255)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

require 'spec_helper'

describe UserContact do
  pending "add some examples to (or delete) #{__FILE__}"
end

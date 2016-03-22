# == Schema Information
#
# Table name: phones
#
#  id             :integer          not null, primary key
#  phone          :string(255)
#  phone_type_id  :string(255)
#  phoneable_id   :integer
#  phoneable_type :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'spec_helper'

describe Phone do
  pending "add some examples to (or delete) #{__FILE__}"
end

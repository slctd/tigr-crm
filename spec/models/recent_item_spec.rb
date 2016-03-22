# == Schema Information
#
# Table name: recent_items
#
#  id            :integer          not null, primary key
#  itemable_id   :integer
#  itemable_type :string(255)
#  user_id       :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  comment       :string(255)
#

require 'spec_helper'

describe RecentItem do
  pending "add some examples to (or delete) #{__FILE__}"
end

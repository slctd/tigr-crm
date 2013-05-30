# == Schema Information
#
# Table name: recent_actions
#
#  id              :integer          not null, primary key
#  actionable_id   :integer
#  actionable_type :string(255)
#  action_type_id  :integer
#  user_id         :integer
#  comment         :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'spec_helper'

describe RecentAction do
  pending "add some examples to (or delete) #{__FILE__}"
end

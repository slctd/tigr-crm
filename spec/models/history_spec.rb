# == Schema Information
#
# Table name: histories
#
#  id              :integer          not null, primary key
#  historable_id   :integer
#  historable_type :string(255)
#  user_id         :integer
#  event_id        :integer
#  deal_id         :integer
#  history_type_id :integer
#  date            :date
#  description     :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'spec_helper'

describe History do
  pending "add some examples to (or delete) #{__FILE__}"
end

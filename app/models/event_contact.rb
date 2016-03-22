# == Schema Information
#
# Table name: participations
#
#  id                   :integer          not null, primary key
#  participatiable_id   :integer
#  participatiable_type :string(255)
#  deal_id              :integer
#  event_id             :integer
#  type                 :string(255)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

class EventContact < Participation
  belongs_to :event
end

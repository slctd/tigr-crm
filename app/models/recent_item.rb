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

class RecentItem < ActiveRecord::Base
  belongs_to :itemable, polymorphic: true
  belongs_to :user  
  
  attr_accessible :user_id
  
  scope :of, lambda {|user_id| where("user_id = ?", user_id).limit(10).order("created_at desc")}
end

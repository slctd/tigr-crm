class RecentAction < ActiveRecord::Base
  belongs_to :action_type
  belongs_to :actionable, polymorphic: true
  belongs_to :user
  
  attr_accessible :action_type_id, :user_id, :comment
  
  scope :by_action_type, lambda {|action_type| where(action_type_id: action_type)}
  scope :by_user, lambda {|user| where(user_id: user)}
  scope :days, where("created_at >= ?", 3.days.ago)
  scope :weeks, where("created_at >= ?", 3.weeks.ago)
  scope :months, where("created_at >= ?", 3.months.ago)  
end
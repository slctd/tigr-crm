class RecentAction < ActiveRecord::Base
  belongs_to :action_type
  belongs_to :actionable, polymorphic: true
  belongs_to :user
  
  attr_accessible :action_type_id, :user_id, :comment
end
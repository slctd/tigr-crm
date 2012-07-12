class RecentItem < ActiveRecord::Base
  belongs_to :itemable, polymorphic: true
  belongs_to :user  
  
  attr_accessible :user_id
  
  scope :of, lambda {|user_id| where("user_id = ?", user_id).limit(10).order("created_at desc")}
end

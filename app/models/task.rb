class Task < ActiveRecord::Base
  belongs_to :task_type
  belongs_to :taskable, polymorphic: true
  belongs_to :user, class_name: "User", foreign_key: "responsible_id"
  
  attr_accessible :deadline_date, :deadline_time, :description, :name, :responsible_id, :task_type_id
  
  validates :name, :task_type, :deadline_date, :responsible_id, :taskable, presence: true
end

class Task < ActiveRecord::Base
  attr_accessible :deadline_date, :deadline_time, :description, :name, :responsible_id, :task_type_id
end

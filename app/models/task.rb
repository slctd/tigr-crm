class Task < ActiveRecord::Base
  attr_accessor :contact
  
  belongs_to :task_type
  belongs_to :taskable, polymorphic: true
  belongs_to :user, class_name: "User", foreign_key: "responsible_id"
  
  attr_accessible :deadline_date,   :description,
                  :name,            :responsible_id,  
                  :task_type_id,    :contact
  
  validates :name, :task_type, :deadline_date, :responsible_id, presence: true
  
  before_validation :set_taskable
  
  private
    def set_taskable
      if self.contact =~ /_/
        contact_id, contact_type = self.contact.split('_')
        self.taskable_id = contact_id unless contact_id.nil?
        self.taskable_type = contact_type unless contact_type.nil?
      else
        self.taskable = nil
      end
    end
end

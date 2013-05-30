# == Schema Information
#
# Table name: tasks
#
#  id            :integer          not null, primary key
#  taskable_id   :integer
#  taskable_type :string(255)
#  event_id      :integer
#  deal_id       :integer
#  name          :string(255)
#  task_type_id  :integer
#  description   :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  deadline_date :date
#  user_id       :integer
#

class Task < ActiveRecord::Base
  attr_accessor :contact
  
  belongs_to :task_type
  belongs_to :taskable, polymorphic: true
  belongs_to :user
  belongs_to :deal
  belongs_to :event
  
  attr_accessible :deadline_date,   :description,
                  :name,            :user_id,  
                  :task_type_id,    :contact,
                  :deal_id,         :event_id
  
  validates :name, :task_type_id, :deadline_date, :user_id, presence: true
  
  before_validation :set_taskable
  
  scope :by_name, lambda {|name| where("name like ?", "%#{name}%")}

  # Attributes to import
  def self.import_columns
    [:name, :description, :contact, :deadline_date, :user, :task_type]
  end

  # Import rules
  def self.import_rules
    {
      name: {
        required: true
      },
      contact: {
        proc: Proc.new { |value| 
            contact = Company.find_by_name(value)
            if contact.nil?
              contact = Person.where('firstname = ? and lastname = ?', value.split[0], value.split[1]).first
            end
            "#{contact.id}_#{contact.class.name}" unless contact.nil?
          }, 
        default: nil
      },
      deadline_date: {required: true},
      user: {
        proc: Proc.new { |value| User.find_by_email(value) }, 
        default: User.current
      },
      task_type: {
        proc: Proc.new { |value|
          task_type = nil
          TaskType.all.each do |type|
            if I18n.t("types.task.#{type.name}") == value
              task_type = type
              break
            end
          end
          task_type
        },
        default: TaskType.find_by_name('note')
      }
    }
  end

  def self.to_csv
    columns = [:name, :task_type, :description, :contact, :deadline_date, :user]
    CSV.generate do |csv|
      csv << columns.map { |column| I18n.t("activerecord.attributes.task.#{column.to_s}")}
      all.each do |task|
        fields = []
        fields << task.name
        fields << I18n.t("types.task.#{task.task_type.name}")
        fields << task.description
        task.taskable.present? ? fields << task.taskable.name : fields << ""
        fields << task.deadline_date
        fields << task.user.email
        csv << fields
      end
    end
  end

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

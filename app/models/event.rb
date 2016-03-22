# == Schema Information
#
# Table name: events
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  opened     :boolean          default(TRUE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Event < ActiveRecord::Base
  has_many :event_contacts
  has_many :people, through: :event_contacts, source: :participatiable, source_type: 'Person'
  has_many :companies, through: :event_contacts, source: :participatiable, source_type: 'Company'
  has_many :histories
  has_many :tasks
  
  attr_accessible :name
  
  validates :name, presence: true
  
  scope :by_name, lambda {|name| where("name like ?", "%#{name}%")}
  
  # Attributes to import
  def self.import_columns
    [:name, :opened]
  end

  # Import rules
  def self.import_rules
    {
      name: {required: true},
      opened: {
        default: true
      }
    }
  end

  def add_participant(participant)
    if participant =~ /_/
      contact_id, contact_type = participant.split('_')
      if contact_type == "Company"
        company = Company.find(contact_id)
        self.companies << company unless self.companies.include?(company)
      else
        person = Person.find(contact_id)
        self.people << person unless self.people.include?(person)
      end
    end
  end
  
  def remove_participant(participant)
    if participant =~ /_/
      contact_id, contact_type = participant.split('_')
      if contact_type == "Company"
        company = Company.find(contact_id)
        self.companies.delete company if self.companies.include?(company)
      else
        person = Person.find(contact_id)
        self.people.delete person if self.people.include?(person)
      end
    end    
  end
  
  def self.to_csv
    columns = [:name, :opened]
    
    CSV.generate do |csv|
      csv << columns.map { |column| I18n.t("activerecord.attributes.event.#{column.to_s}")}

      all.each do |event|
        fields = []
        
        fields << event.name
        fields << event.opened.to_s

        csv << fields
      end
    end
  end
end

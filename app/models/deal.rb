class Deal < ActiveRecord::Base
  attr_accessor :contact
  
  belongs_to :budget_type
  belongs_to :stage
  belongs_to :currency
  belongs_to :user, class_name: "User", foreign_key: "responsible_id"
  belongs_to :dealable, polymorphic: true  
  has_many :deal_contacts
  has_many :people, through: :deal_contacts, source: :participatiable, source_type: 'Person'
  has_many :companies, through: :deal_contacts, source: :participatiable, source_type: 'Company'
  has_many :tasks
  
  attr_accessible :budget,              :budget_type_id, 
                  :closing_date,        :currency_id,
                  :description,         :name,
                  :responsible_id,      :stage_id,
                  :success_probability, :contact

  after_initialize :set_success_probability
                  
  before_validation :set_success_probability
  before_validation :set_dealable
                  
  validates :name, :closing_date, :responsible_id, :stage_id, presence: true
  validates :budget, numericality: { greater_than_or_equal_to: 0 }, allow_blank: true
  validates :success_probability, numericality: { only_integer: true,
                                                  greater_than_or_equal_to: 0,
                                                  less_than_or_equal_to: 100 }

  def responsible
    User.find(self.responsible_id)
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
  
  private
  
    def set_dealable
      if self.contact =~ /_/
        self.add_participant(contact)
        contact_id, contact_type = self.contact.split('_')
        # Remove old
        #if contact_type == "Company"
        #  self.companies.delete(Company.find(contact_id)) if self.companies.includes(Company.find(contact_id))
        #end
        #if contact_type == "Person"
        #  self.people.delete(Person.find(contact_id)) if self.people.includes(Person.find(contact_id))
        #end
        self.dealable_id = contact_id unless contact_id.nil?
        self.dealable_type = contact_type unless contact_type.nil?
      else
        self.dealable = nil
      end
    end
  
    def set_success_probability
      self.success_probability = 0 if self.success_probability.nil?
      self.success_probability = 0 if self.success_probability < 0
      self.success_probability = 100 if self.success_probability > 100
    end
end
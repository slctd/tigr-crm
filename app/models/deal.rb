# == Schema Information
#
# Table name: deals
#
#  id                  :integer          not null, primary key
#  dealable_id         :integer
#  dealable_type       :string(255)
#  name                :string(255)
#  description         :text
#  currency_id         :integer
#  budget              :decimal(, )
#  budget_type_id      :integer
#  closing_date        :date
#  stage_id            :integer
#  success_probability :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  user_id             :integer
#

class Deal < ActiveRecord::Base
  attr_accessor :contact
  
  belongs_to :budget_type
  belongs_to :stage
  belongs_to :currency
  belongs_to :user
  belongs_to :dealable, polymorphic: true  
  has_many :deal_contacts
  has_many :people, through: :deal_contacts, source: :participatiable, source_type: 'Person'
  has_many :companies, through: :deal_contacts, source: :participatiable, source_type: 'Company'
  has_many :tasks
  has_many :histories
  
  attr_accessible :budget,              :budget_type_id, 
                  :closing_date,        :currency_id,
                  :description,         :name,
                  :user_id,            :stage_id,
                  :success_probability, :contact

  after_initialize :set_success_probability
                  
  before_validation :set_success_probability
  before_validation :set_dealable
                  
  validates :name, :closing_date, :user_id, :stage_id, presence: true
  validates :budget, numericality: { greater_than_or_equal_to: 0 }, allow_blank: true
  validates :success_probability, numericality: { only_integer: true,
                                                  greater_than_or_equal_to: 0,
                                                  less_than_or_equal_to: 100 }
  
  scope :by_name, lambda {|name| where("name like ?", "%#{name}%")}
  
  # Attributes to import
  def self.import_columns
    [:name, :description, :contact, :currency, :budget, :budget_type, :closing_date, :user, :stage, :success_probability]
  end

  # Import rules
  def self.import_rules
    {
      name: {required: true},
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
      currency: {
        proc: Proc.new { |value|
          Currency.find_by_name(value) || Currency.find_by_abbreviation(value)
        },
        default: Currency.first
      },
      budget_type: {
        proc: Proc.new { |value|
          budget_type = nil
          BudgetType.all.each do |type|
            if I18n.t("types.budget.#{type.name}") == value
              budget_type = type
              break
            end
          end
          budget_type
        },
        default: BudgetType.first
      },
      closing_date: {required: true},
      user: {
        proc: Proc.new { |value| User.find_by_email(value) }, 
        default: User.current
      },
      stage: {
        proc: Proc.new { |value|
          my_stage = nil
          Stage.all.each do |stage|
            if I18n.t("stages.#{stage.name}") == value
              my_stage = stage
              break
            end
          end
          my_stage
        },
        default: Stage.find_by_success_probability(0)
      }
    }
  end

  def responsible
    User.find(self.user_id)
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
        return if self.dealable == company
        self.companies.delete company if self.companies.include?(company)
      else
        person = Person.find(contact_id)
        return if self.dealable == person
        self.people.delete person if self.people.include?(person)
      end
    end    
  end

  def self.to_csv
    columns = [:name, :contact, :description, :currency, :budget, :budget_type, :closing_date, :user, :stage, :success_probability]
    CSV.generate do |csv|
      csv << columns.map { |column| I18n.t("activerecord.attributes.deal.#{column.to_s}")}

      all.each do |deal|
        fields = []
        
        fields << deal.name
        deal.dealable.present? ? fields << deal.dealable.name : fields << ""
        fields << deal.description
        fields << deal.currency.name
        fields << deal.budget || ""
        fields << I18n.t("types.budget.#{deal.budget_type.name}")
        fields << deal.closing_date
        fields << deal.user.email
        fields << I18n.t("stages.#{deal.stage.name}")
        fields << deal.success_probability || ""
        
        csv << fields
      end
    end
  end
  
  private
  
    def set_dealable
      if self.contact =~ /_/
        contact_id, contact_type = self.contact.split('_')
        delete_old_participant(contact_id, contact_type)
        self.add_participant(contact)
        self.dealable_id = contact_id unless contact_id.nil?
        self.dealable_type = contact_type unless contact_type.nil?
      else
        delete_old_participant
        self.dealable = nil
      end
    end
  
    def delete_old_participant(contact_id=nil, contact_type=nil)
      unless self.dealable.nil?
        unless contact_id == self.dealable_id && contact_type == self.dealable_type
          if self.dealable.is_a?(Company)
            self.companies.delete(self.dealable) if self.companies.includes(self.dealable)
          else
            self.people.delete(self.dealable) if self.people.includes(self.dealable)
          end
        end
      end
    end
    
    def set_success_probability
      self.success_probability = 0 if self.success_probability.nil?
      self.success_probability = 0 if self.success_probability < 0
      self.success_probability = 100 if self.success_probability > 100
    end
end

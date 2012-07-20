class Person < ActiveRecord::Base
  scope :free, where(company_id: nil)
  
  belongs_to :company
  has_many :emails, as: :emailable, inverse_of: :emailable, dependent: :destroy
  has_many :phones, as: :phoneable, inverse_of: :phoneable, dependent: :destroy
  has_many :addresses, as: :addressable, inverse_of: :addressable, dependent: :destroy
  has_many :histories, as: :historable
  has_many :tasks, as: :taskable
  has_many :deal_contacts, as: :participatiable
  has_many :deals, through: :deal_contacts
  has_many :event_contacts, as: :participatiable
  has_many :events, through: :event_contacts
  belongs_to :contact_type
  
  mount_uploader :image, ImageUploader
  
  accepts_nested_attributes_for :emails, allow_destroy: true
  accepts_nested_attributes_for :phones, allow_destroy: true
  accepts_nested_attributes_for :addresses, allow_destroy: true
  
  attr_accessible :company_id, :company_name, 
                  :description, :firstname, 
                  :job, :lastname, 
                  :emails_attributes, :phones_attributes,
                  :contact_type_id, :image, 
                  :remove_image, :addresses_attributes
                  
  validates :firstname, :lastname, presence: true
  
  scope :by_name, lambda {|name| where("firstname like ? OR lastname like ?", "#{name}%", "#{name}%")}

# Attributes to import
  def self.import_columns
    [:firstname, :lastname, :job, :name => :alias]
  end

  # Import rules
  def self.import_rules
    {
      firstname: {required: true},
      lastname: {required: true},
      name: { alias_to: 'company_name' }
    }
  end

  def name
    "#{firstname} #{lastname}"  
  end
  
  def company_name
    company.try(:name)
  end
  
  def company_name=(name)
    self.company = Company.find_or_create_by_name(name) if name.present?
  end
  
  def id_with_class_name
    "#{id}_#{self.class.name}"
  end
end

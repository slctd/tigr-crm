class Person < ActiveRecord::Base
  scope :free, where(company_id: nil)
  
  belongs_to :company
  has_many :emails, as: :emailable, inverse_of: :emailable, dependent: :destroy
  has_many :phones
  has_many :addresses
  has_many :tasks, as: :taskable, dependent: :destroy
  
  accepts_nested_attributes_for :emails, allow_destroy: true
  
  attr_accessible :company_id, :company_name, :description, :firstname, :job, :lastname, :emails_attributes
  
  validates :firstname, :lastname, presence: true
  
  def company_name
    company.try(:name)
  end
  
  def company_name=(name)
    self.company = Company.find_or_create_by_name(name) if name.present?
  end
end

class Person < ActiveRecord::Base
  belongs_to :company
  has_many :emails, as: :emailable, inverse_of: :emailable, dependent: :destroy
  has_many :phones
  has_many :addresses
  
  accepts_nested_attributes_for :emails, allow_destroy: true
  
  attr_accessible :company_id, :description, :firstname, :job, :lastname
  
  validates :firstname, :lastname, presence: true
end

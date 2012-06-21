class Company < ActiveRecord::Base
  has_many :people
  has_many :emails, as: :emailable, inverse_of: :emailable, dependent: :destroy
  has_many :phones
  #has_many :webs
  has_many :addresses
  
  accepts_nested_attributes_for :emails, allow_destroy: true
  
  attr_accessible :name, :description, :emails_attributes
  
  validates :name, presence: true
end

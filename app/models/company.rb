class Company < ActiveRecord::Base
  has_many :emails
  has_many :phones
  #has_many :webs
  has_many :addresses
  
  attr_accessible :name
  
  validates :name, presence: true
end

class ContactType < Type
  has_many :companies
  has_many :people  
end
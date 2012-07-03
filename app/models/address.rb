class Address < ActiveRecord::Base
  belongs_to :address_type
  belongs_to :addressable, polymorphic: true, inverse_of: :addresses
  
  attr_accessible :address, :city, :country, :postal_code, :state, :address_type_id
  
  validates :address_type_id, presence: true
end

class Address < ActiveRecord::Base
  belongs_to :address_type
  attr_accessible :address, :city, :country, :postal_code, :state
end

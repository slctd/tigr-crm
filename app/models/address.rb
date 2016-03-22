# == Schema Information
#
# Table name: addresses
#
#  id               :integer          not null, primary key
#  address          :string(255)
#  city             :string(255)
#  state            :string(255)
#  postal_code      :string(255)
#  country          :string(255)
#  address_type_id  :string(255)
#  addressable_id   :integer
#  addressable_type :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Address < ActiveRecord::Base
  belongs_to :address_type
  belongs_to :addressable, polymorphic: true, inverse_of: :addresses
  
  attr_accessible :address, :city, :country, :postal_code, :state, :address_type_id
  
  validates :address_type_id, presence: true
end

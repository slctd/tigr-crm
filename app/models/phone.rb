class Phone < ActiveRecord::Base
  belongs_to :phone_type
  belongs_to :phoneable, polymorphic: true, inverse_of: :phones

  
  attr_accessible :phone, :phone_type_id
  
  validates :phone, :phone_type_id, presence: true  
end

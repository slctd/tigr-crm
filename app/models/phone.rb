# == Schema Information
#
# Table name: phones
#
#  id             :integer          not null, primary key
#  phone          :string(255)
#  phone_type_id  :string(255)
#  phoneable_id   :integer
#  phoneable_type :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Phone < ActiveRecord::Base
  belongs_to :phone_type
  belongs_to :phoneable, polymorphic: true, inverse_of: :phones

  
  attr_accessible :phone, :phone_type_id
  
  validates :phone, :phone_type_id, presence: true  
end

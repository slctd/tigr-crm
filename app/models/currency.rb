# == Schema Information
#
# Table name: currencies
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  abbreviation :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Currency < ActiveRecord::Base
  has_many :deals
  
  attr_accessible :abbreviation, :name
  
  validates :name, :abbreviation, presence: true,
                                  uniqueness: { case_sensitive: false }
end

class Currency < ActiveRecord::Base
  has_many :deals
  
  attr_accessible :abbreviation, :name
  
  validates :name, :abbreviation, presence: true,
                                  uniqueness: { case_sensitive: false }
end

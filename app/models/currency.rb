class Currency < ActiveRecord::Base
  attr_accessible :abbreviation, :name
  
  validates :name, :abbreviation, presence: true,
                                  uniqueness: { case_sensitive: false }
end

class Stage < ActiveRecord::Base
  has_many :deals
  
  attr_accessible :name, :success_probability
  
  validates :name,  presence: true,
                    uniqueness: { case_sensitive:  false }
  validates :success_probability, numericality: { only_integer: true,
                                                  greater_than_or_equal_to: 0,
                                                  less_than_or_equal_to: 100 }
                                                  
  before_validation do
    self.success_probability = 0 if self.success_probability.nil?
    self.success_probability = 0 if self.success_probability < 0
    self.success_probability = 100 if self.success_probability > 100
  end
end

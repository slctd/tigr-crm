class Phone < ActiveRecord::Base
  belongs_to :phone_type
  attr_accessible :phone
end

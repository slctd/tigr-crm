class Participation < ActiveRecord::Base
  belongs_to :participatiable, polymorphic: true
  
  #attr_accessible :participatiable
end

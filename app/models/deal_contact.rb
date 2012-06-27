class DealContact < Participation
  belongs_to :deal
  
  #validates_uniqueness_of :participatiable, scope: [:deal]
end

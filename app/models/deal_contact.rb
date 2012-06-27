class DealContact < Participation
  belongs_to :deal
  
  validates_uniqueness_of :deal_id, scope: [:participatiable_id, :participatiable_type]
end

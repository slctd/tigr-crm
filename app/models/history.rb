class History < ActiveRecord::Base
  attr_accessor :contact
  
  belongs_to :history_type
  belongs_to :historable, polymorphic: true
  belongs_to :deal
  belongs_to :user
    
  attr_accessible :date, :deal_id, :description, :event_id, :history_type_id, :contact
  
  before_validation :set_historable
  
  validates :user_id, :history_type_id, :date, :description, presence: true
  
  private
    def set_historable
      if self.contact =~ /_/
        contact_id, contact_type = self.contact.split('_')
        self.historable_id = contact_id unless contact_id.nil?
        self.historable_type = contact_type unless contact_type.nil?
      else
        self.historable = nil
      end
    end  
end

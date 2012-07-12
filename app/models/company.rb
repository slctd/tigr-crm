class Company < ActiveRecord::Base
  has_many :people
  has_many :emails, as: :emailable, inverse_of: :emailable, dependent: :destroy
  has_many :phones, as: :phoneable, inverse_of: :phoneable, dependent: :destroy
  has_many :addresses, as: :addressable, inverse_of: :addressable, dependent: :destroy
  has_many :histories, as: :historable
  has_many :tasks, as: :taskable
  has_many :deal_contacts, as: :participatiable
  has_many :deals, through: :deal_contacts
  has_many :event_contacts, as: :participatiable
  has_many :events, through: :event_contacts
  belongs_to :contact_type
  
  mount_uploader :image, ImageUploader
  
  accepts_nested_attributes_for :emails, allow_destroy: true
  accepts_nested_attributes_for :phones, allow_destroy: true  
  accepts_nested_attributes_for :addresses, allow_destroy: true  
  
  attr_accessible :name, :description,
                  :emails_attributes, :phones_attributes,
                  :contact_type_id, :image,
                  :remove_image, :addresses_attributes
  
  validates :name, presence: true,
                   uniqueness: { case_sensitive:  false }
  
  scope :by_name, lambda {|name| where("name like ?", "%#{name}%")}
                  
  def id_with_class_name
    "#{id}_#{self.class.name}"
  end
end

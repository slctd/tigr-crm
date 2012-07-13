class UserContact < ActiveRecord::Base
  belongs_to :user_contact_type
  belongs_to :user, inverse_of: :user_contacts
  attr_accessible :user_contact, :user_contact_type_id
end
# == Schema Information
#
# Table name: user_contacts
#
#  id                   :integer          not null, primary key
#  user_id              :integer
#  user_contact_type_id :integer
#  user_contact         :string(255)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

class UserContact < ActiveRecord::Base
  belongs_to :user_contact_type
  belongs_to :user, inverse_of: :user_contacts
  attr_accessible :user_contact, :user_contact_type_id
end

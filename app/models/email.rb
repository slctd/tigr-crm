# == Schema Information
#
# Table name: emails
#
#  id             :integer          not null, primary key
#  email          :string(255)
#  email_type_id  :string(255)
#  emailable_id   :integer
#  emailable_type :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Email < ActiveRecord::Base
  belongs_to :email_type
  belongs_to :emailable, polymorphic: true, inverse_of: :emails

  attr_accessible :email, :email_type_id
 
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i      
  validates :email, format: { with: email_regex }#, uniqueness: { case_sensitive: false }
  validates :email, :email_type, presence: true
end

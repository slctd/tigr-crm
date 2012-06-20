class Email < ActiveRecord::Base
  belongs_to :email_type
  attr_accessible :email
end

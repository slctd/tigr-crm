class User < ActiveRecord::Base
  has_many :tasks
  has_many :deals
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  # :trackable, :validatable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body
  
  validates :email, presence: true,
                    uniqueness: { case_sensitive:  false }
end

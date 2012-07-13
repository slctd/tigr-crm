class User < ActiveRecord::Base
  has_many :tasks
  has_many :deals
  has_many :histories
  has_many :recent_actions, dependent: :destroy    
  has_many :recent_items, dependent: :destroy
  has_many :authentications
  has_many :user_contacts, inverse_of: :user, dependent: :destroy
  
  accepts_nested_attributes_for :user_contacts, allow_destroy: true
  
  mount_uploader :image, ImageUploader
  
  nilify_blanks :only => [:name]
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  # :trackable, :validatable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :name, :gender, :birthday, :comment, :user_contacts_attributes, :image, :remove_image
  
  validates :password, :password_confirmation, presence: true, on: :create
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i      
  validates :email, presence: true,
                    uniqueness: { case_sensitive:  false },
                    format: { with: email_regex }
                    
  def self.current
    Thread.current[:user]
  end
  
  def self.current=(user)
    Thread.current[:user] = user
  end
end
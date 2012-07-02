class Participation < ActiveRecord::Base
  belongs_to :participatiable, polymorphic: true
end

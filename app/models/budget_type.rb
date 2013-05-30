# == Schema Information
#
# Table name: types
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  type       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class BudgetType < Type
  has_many :deals
end

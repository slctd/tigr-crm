# == Schema Information
#
# Table name: import_tables
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ImportTable < ActiveRecord::Base
  has_many :import_rows, dependent: :destroy
end

# == Schema Information
#
# Table name: import_cells
#
#  id            :integer          not null, primary key
#  import_row_id :integer
#  number        :integer
#  header        :text
#  data          :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class ImportCell < ActiveRecord::Base
  belongs_to :import_row
  attr_accessible :header, :data, :number

  validates :import_row, :header, presence: true

  before_create do |cell|
    cell.number = cell.import_row.import_cells.count + 1
  end
end

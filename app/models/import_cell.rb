class ImportCell < ActiveRecord::Base
  belongs_to :import_row
  attr_accessible :header, :data, :number

  validates :import_row, :header, presence: true

  before_create do |cell|
    cell.number = cell.import_row.import_cells.count + 1
  end
end

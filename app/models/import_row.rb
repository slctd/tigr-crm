class ImportRow < ActiveRecord::Base
  belongs_to :import_table
  has_many :import_cells, dependent: :destroy
  attr_accessible :number

  validates :import_table, presence: true

  before_create do |row|
    row.number = row.import_table.import_rows.count + 1
  end
end

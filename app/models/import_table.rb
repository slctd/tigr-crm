class ImportTable < ActiveRecord::Base
  has_many :import_rows, dependent: :destroy
end

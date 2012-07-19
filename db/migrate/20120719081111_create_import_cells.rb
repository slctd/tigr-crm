class CreateImportCells < ActiveRecord::Migration
  def change
    create_table :import_cells do |t|
      t.integer :import_row_id
      t.integer :number
      t.text :header
      t.text :data

      t.timestamps
    end
  end
end

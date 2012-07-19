class CreateImportRows < ActiveRecord::Migration
  def change
    create_table :import_rows do |t|
      t.integer :import_table_id
      t.integer :number

      t.timestamps
    end
  end
end

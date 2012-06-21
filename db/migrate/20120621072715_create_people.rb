class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :firstname
      t.string :lastname
      t.integer :company_id
      t.string :job
      t.text :description

      t.timestamps
    end
  end
end

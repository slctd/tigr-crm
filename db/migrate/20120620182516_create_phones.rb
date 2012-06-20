class CreatePhones < ActiveRecord::Migration
  def change
    create_table :phones do |t|
      t.string :phone
      t.string :phone_type_id
      t.references :phoneable, polymorphic: true
      t.timestamps
    end
  end
end

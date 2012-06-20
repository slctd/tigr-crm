class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :address
      t.string :city
      t.string :state
      t.string :postal_code
      t.string :country
      t.string :address_type_id
      t.references :addressable, polymorphic: true
      t.timestamps
    end
  end
end

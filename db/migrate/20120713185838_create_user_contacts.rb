class CreateUserContacts < ActiveRecord::Migration
  def change
    create_table :user_contacts do |t|
      t.integer :user_id
      t.integer :user_contact_type_id
      t.string :user_contact

      t.timestamps
    end
  end
end

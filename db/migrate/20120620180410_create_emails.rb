class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.string :email
      t.string :email_type_id
      t.references :emailable, polymorphic: true
      t.timestamps
    end
  end
end

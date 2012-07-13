class AddPersonalDataToUsers < ActiveRecord::Migration
  def change
    add_column :users, :gender, :string
    add_column :users, :birthday, :date
    add_column :users, :comment, :text
  end
end

class AddContactTypeToCompaniesAndPeople < ActiveRecord::Migration
  def change
    add_column :companies, :contact_type_id, :integer
    add_column :people, :contact_type_id, :integer    
  end
end

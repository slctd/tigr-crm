class AddImageToContacts < ActiveRecord::Migration
  def change
    add_column :companies, :image, :string
    add_column :people, :image, :string
  end
end

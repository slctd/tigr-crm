class CreateCurrencies < ActiveRecord::Migration
  def change
    create_table :currencies do |t|
      t.string :name
      t.string :abbreviation

      t.timestamps
    end
    add_index :currencies, :name, unique: true
    add_index :currencies, :abbreviation, unique: true
  end
end

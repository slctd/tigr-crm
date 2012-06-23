class CreateDeals < ActiveRecord::Migration
  def change
    create_table :deals do |t|
      t.references :dealable, polymorphic: true      
      t.string :name
      t.text :description
      t.integer :currency_id
      t.decimal :budget
      t.integer :budget_type_id
      t.date :closing_date
      t.integer :responsible_id
      t.integer :stage_id
      t.integer :success_probability

      t.timestamps
    end
  end
end

class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.references :historable, polymorphic: true      
      t.integer :user_id
      t.integer :event_id
      t.integer :deal_id
      t.integer :history_type_id
      t.date :date
      t.text :description

      t.timestamps
    end
  end
end

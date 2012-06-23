class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.references :taskable, polymorphic: true
      t.integer :event_id
      t.integer :deal_id
      t.string :name
      t.integer :task_type_id
      t.datetime :deadline_date
      t.integer :responsible_id
      t.string :description
      t.timestamps
    end
  end
end

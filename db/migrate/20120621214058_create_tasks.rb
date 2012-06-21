class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.integer :task_type_id
      t.date :deadline_date
      t.time :deadline_time
      t.integer :responsible_id
      t.string :description
      t.references :taskable, polymorphic: true
      t.timestamps
    end
  end
end

class AddDateInsteadOfDatetimeToTasks < ActiveRecord::Migration
  def up
    remove_column :tasks, :deadline_date
    add_column :tasks, :deadline_date, :date
  end

  def down
    remove_column :tasks, :deadline_date
    add_column :tasks, :deadline_date, :datetime
  end
end

class RenameResponsibleToUser < ActiveRecord::Migration
  def up
    remove_column :tasks, :responsible_id
    add_column :tasks, :user_id, :integer
    remove_column :deals, :responsible_id
    add_column :deals, :user_id, :integer
  end

  def down
    remove_column :tasks, :user_id
    add_column :tasks, :responsible_id, :integer
    remove_column :deals, :user_id
    add_column :deals, :responsible_id, :integer
  end
end

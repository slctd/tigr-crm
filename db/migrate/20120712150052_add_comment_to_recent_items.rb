class AddCommentToRecentItems < ActiveRecord::Migration
  def change
    add_column :recent_items, :comment, :string
  end
end

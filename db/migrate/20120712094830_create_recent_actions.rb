class CreateRecentActions < ActiveRecord::Migration
  def change
    create_table :recent_actions do |t|
      t.references :actionable, polymorphic: true
      t.integer :action_type_id
      t.integer :user_id
      t.string :comment

      t.timestamps
    end
  end
end

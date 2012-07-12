class CreateRecentItems < ActiveRecord::Migration
  def change
    create_table :recent_items do |t|
      t.references :itemable, polymorphic: true
      t.integer :user_id
      
      t.timestamps
    end
  end
end

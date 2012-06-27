class CreateParticipations < ActiveRecord::Migration
  def change
    create_table :participations do |t|
      t.references :participatiable, polymorphic: true
      t.integer :deal_id
      t.integer :event_id
      t.string :type
      
      t.timestamps
    end
  end
end

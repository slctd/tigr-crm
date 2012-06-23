class CreateStages < ActiveRecord::Migration
  def change
    create_table :stages do |t|
      t.string :name
      t.integer :success_probability

      t.timestamps
    end
    add_index :stages, :name, unique: true
  end
end

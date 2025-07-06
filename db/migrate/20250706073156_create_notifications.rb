class CreateNotifications < ActiveRecord::Migration[7.1]
  def change
    create_table :notifications do |t|
      t.text :message, null: false
      t.references :project_manager, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true
      t.datetime :read_at

      t.timestamps
    end
    
    add_index :notifications, :read_at
  end
end

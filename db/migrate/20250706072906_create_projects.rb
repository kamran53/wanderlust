class CreateProjects < ActiveRecord::Migration[7.1]
  def change
    create_table :projects do |t|
      t.string :name, null: false
      t.string :status, null: false, default: 'pending'
      t.string :raw_footage_link, null: false
      t.references :client, null: false, foreign_key: true
      t.references :project_manager, null: false, foreign_key: true

      t.timestamps
    end
    
    add_index :projects, :status
  end
end

class CreateProjectManagers < ActiveRecord::Migration[7.1]
  def change
    create_table :project_managers do |t|
      t.string :name, null: false
      t.string :email, null: false

      t.timestamps
    end
    
    add_index :project_managers, :email, unique: true
  end
end

class CreateVideoTypes < ActiveRecord::Migration[7.1]
  def change
    create_table :video_types do |t|
      t.string :name, null: false
      t.text :description
      t.integer :price, null: false, default: 0

      t.timestamps
    end
    
    add_index :video_types, :name, unique: true
  end
end

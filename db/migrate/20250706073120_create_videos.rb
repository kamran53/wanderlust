class CreateVideos < ActiveRecord::Migration[7.1]
  def change
    create_table :videos do |t|
      t.references :project, null: false, foreign_key: true
      t.references :video_type, null: false, foreign_key: true
      t.string :complete_video_link

      t.timestamps
    end
  end
end

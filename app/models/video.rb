class Video < ApplicationRecord
  belongs_to :project
  belongs_to :video_type
  
  validates :project, presence: true
  validates :video_type, presence: true
end

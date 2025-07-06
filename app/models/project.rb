class Project < ApplicationRecord
  belongs_to :client
  belongs_to :project_manager
  
  has_many :videos, dependent: :destroy
  
  validates :name, presence: true
  validates :status, presence: true, inclusion: { in: %w[pending in_progress completed cancelled] }
  validates :raw_footage_link, presence: true, format: { with: URI::regexp(%w[http https]) }
  
  scope :in_progress, -> { where(status: 'in_progress') }
  scope :completed, -> { where(status: 'completed') }
  scope :pending, -> { where(status: 'pending') }
  
  def total_price
    videos.joins(:video_type).sum('video_types.price')
  end
end

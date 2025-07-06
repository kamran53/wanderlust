class Notification < ApplicationRecord
  belongs_to :project_manager
  belongs_to :project
  
  validates :message, presence: true
  validates :project_manager, presence: true
  validates :project, presence: true
  
  scope :unread, -> { where(read_at: nil) }
  scope :read, -> { where.not(read_at: nil) }
  
  def mark_as_read!
    update!(read_at: Time.current)
  end
  
  def read?
    read_at.present?
  end
end

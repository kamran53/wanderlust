class ProjectManager < ApplicationRecord
  has_many :projects, foreign_key: :project_manager_id, dependent: :destroy
  has_many :notifications, dependent: :destroy
  
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end

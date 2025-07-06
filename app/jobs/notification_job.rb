class NotificationJob < ApplicationJob
  queue_as :default

  def perform(project_manager_id, project_id, message)
    project_manager = ProjectManager.find(project_manager_id)
    project = Project.find(project_id)
    
    Notification.create!(
      project_manager: project_manager,
      project: project,
      message: message
    )
  end
end

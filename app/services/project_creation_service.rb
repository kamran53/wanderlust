class ProjectCreationService
  attr_reader :project, :errors
  
  def initialize(client, params)
    @client = client
    @params = params
    @errors = []
  end
  
  def call
    ActiveRecord::Base.transaction do
      assign_project_manager
      create_project
      create_videos
      update_project_status
      create_notification
      
      true
    rescue => e
      @errors << e.message
      false
    end
  end
  
  private
  
  def assign_project_manager
    # Assign the first available PM (in a real app, it'll be changes as per the business logic)
    @project_manager = ProjectManager.first
    if @project_manager.nil?
      @errors << "No project managers available"
      raise ActiveRecord::Rollback
    end
  end
  
  def create_project
    @project = @client.projects.build(
      name: @params[:name],
      raw_footage_link: @params[:raw_footage_link],
      status: 'pending',
      project_manager: @project_manager
    )
    
    unless @project.save
      @errors.concat(@project.errors.full_messages)
      raise ActiveRecord::Rollback
    end
  end
  
  def create_videos
    ids = Array(@params[:video_type_ids]).reject(&:blank?)
    unless ids.present?
      @errors << "No video types selected"
      raise ActiveRecord::Rollback
    end
    
    ids.each do |video_type_id|
      video_type = VideoType.find(video_type_id)
      @project.videos.create!(video_type: video_type)
    end
  end
  
  def update_project_status
    @project.update!(status: 'in_progress')
  end
  
  def create_notification
    # Create notification in background job
    NotificationJob.perform_later(
      @project.project_manager.id,
      @project.id,
      "New project '#{@project.name}' has been assigned to you"
    )
  end
end 
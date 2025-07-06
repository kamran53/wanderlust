class ProjectsController < ApplicationController
  before_action :set_current_client
  
  def index
    @projects = @current_client.projects.includes(:videos, :project_manager, videos: :video_type)
                               .order(created_at: :desc)
  end
  
  def order_project
    @video_types = VideoType.all.order(:name)
    @project = @current_client.projects.build
  end
  
  def create_order
    service = ProjectCreationService.new(@current_client, order_params)
    
    if service.call
      redirect_to projects_path, notice: 'Project was successfully created and assigned to a Project Manager.'
    else
      @video_types = VideoType.all.order(:name)
      @project = service.project
      @service_errors = service.errors
      render :order_project, status: :unprocessable_entity
    end
  end
  
  private
  
  def set_current_client
    # For demo purposes, we'll use the last client
    # In a real app, this would come from authentication
    @current_client = Client.last
  end
  
  def project_params
    params.require(:project).permit(:name, :raw_footage_link, :status)
  end
  
  def order_params
    params.require(:project).permit(:name, :raw_footage_link, video_type_ids: [])
  end
end

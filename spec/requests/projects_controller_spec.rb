require 'rails_helper'

describe "ProjectsController", type: :request do
  let!(:client) { create(:client) }
  let!(:project_manager) { create(:project_manager) }
  let!(:video_type1) { create(:video_type) }
  let!(:video_type2) { create(:video_type) }

  before do
    allow(Client).to receive(:last).and_return(client)
    allow(ProjectManager).to receive(:first).and_return(project_manager)
  end

  describe 'GET /projects' do
    it 'renders the index template and shows projects' do
      project = create(:project, client: client, project_manager: project_manager)
      get projects_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(project.name)
    end
  end

  describe 'GET /projects/order_project' do
    it 'renders the order_project template' do
      get order_project_projects_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('Order New Project')
    end
  end

  describe 'POST /projects/create_order' do
    it 'creates a new project and redirects to projects index' do
      expect {
        post create_order_projects_path, params: {
          project: {
            name: 'New Project',
            raw_footage_link: 'http://example.com/raw.mp4',
            video_type_ids: [video_type1.id, video_type2.id]
          }
        }
      }.to change(Project, :count).by(1)
      expect(response).to redirect_to(projects_path)
      follow_redirect!
      expect(response.body).to include('Project was successfully created and assigned to a Project Manager')
    end

    it 'renders order_project on failure (missing name)' do
      post create_order_projects_path, params: {
        project: {
          name: '',
          raw_footage_link: 'http://example.com/raw.mp4',
          video_type_ids: [video_type1.id]
        }
      }
      expect(response.body).to include('Order New Project')
      expect(response.body).to include('Project name is required').or include('can&#39;t be blank')
    end

    it 'renders order_project on failure (no video types)' do
      post create_order_projects_path, params: {
        project: {
          name: 'No Videos',
          raw_footage_link: 'http://example.com/raw.mp4',
          video_type_ids: []
        }
      }
      expect(response.body).to include('Order New Project')
      expect(response.body).to include('No video types selected').or include('must select at least one video type')
    end
  end
end 
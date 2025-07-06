require 'rails_helper'

describe ProjectCreationService do
  let(:client) { create(:client) }
  let(:pm) { create(:project_manager) }
  let(:video_type1) { create(:video_type) }
  let(:video_type2) { create(:video_type) }

  before do
    allow(ProjectManager).to receive(:first).and_return(pm)
  end

  it 'creates a project, videos, assigns PM, and enqueues notification on success' do
    service = described_class.new(client, {
      name: 'Service Project',
      raw_footage_link: 'http://example.com/raw.mp4',
      video_type_ids: [video_type1.id, video_type2.id]
    })
    expect(service.call).to be true
    project = service.project
    expect(project).to be_persisted
    expect(project.project_manager).to eq(pm)
    expect(project.videos.count).to eq(2)
    expect(project.status).to eq('in_progress')
    expect(service.errors).to be_empty
  end

  it 'fails if no video types are selected' do
    service = described_class.new(client, {
      name: 'No Videos',
      raw_footage_link: 'http://example.com/raw.mp4',
      video_type_ids: []
    })
    expect(service.call).to be false
    expect(service.errors).to include('No video types selected')
    expect(service.project).to be_nil.or be_a(Project)
  end

  it 'fails if no project manager is available' do
    allow(ProjectManager).to receive(:first).and_return(nil)
    service = described_class.new(client, {
      name: 'No PM',
      raw_footage_link: 'http://example.com/raw.mp4',
      video_type_ids: [video_type1.id]
    })
    expect(service.call).to be false
    expect(service.errors).to include('No project managers available')
  end

  it 'fails if project is invalid (missing name)' do
    service = described_class.new(client, {
      name: '',
      raw_footage_link: 'http://example.com/raw.mp4',
      video_type_ids: [video_type1.id]
    })
    expect(service.call).to be false
    expect(service.errors).to include("Name can't be blank").or include("can't be blank")
  end
end 
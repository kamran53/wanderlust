require 'rails_helper'

describe Project, type: :model do
  it { should belong_to(:client) }
  it { should belong_to(:project_manager) }
  it { should have_many(:videos).dependent(:destroy) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:status) }
  it { should validate_inclusion_of(:status).in_array(%w[pending in_progress completed cancelled]) }
  it { should validate_presence_of(:raw_footage_link) }
  it { should allow_value('http://example.com').for(:raw_footage_link) }
  it { should_not allow_value('invalid').for(:raw_footage_link) }

  describe '#total_price' do
    it 'returns the sum of video type prices for all videos' do
      project = create(:project)
      vt1 = create(:video_type, price: 1000)
      vt2 = create(:video_type, price: 2000)
      create(:video, project: project, video_type: vt1)
      create(:video, project: project, video_type: vt2)
      expect(project.total_price).to eq(3000)
    end
  end
end 
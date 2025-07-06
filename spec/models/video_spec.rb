require 'rails_helper'

describe Video, type: :model do
  it { should belong_to(:project) }
  it { should belong_to(:video_type) }
  it { should validate_presence_of(:project) }
  it { should validate_presence_of(:video_type) }
end 
require 'rails_helper'

describe ProjectManager, type: :model do
  it { should have_many(:projects).dependent(:destroy) }
  it { should have_many(:notifications).dependent(:destroy) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it {
    create(:project_manager)
    should validate_uniqueness_of(:email).case_insensitive
  }
  it { should allow_value('pm@example.com').for(:email) }
  it { should_not allow_value('invalid').for(:email) }
end

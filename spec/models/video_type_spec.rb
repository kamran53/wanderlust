require 'rails_helper'

describe VideoType, type: :model do
  it { should have_many(:videos).dependent(:destroy) }
  it { should validate_presence_of(:name) }
  it {
    create(:video_type)
    should validate_uniqueness_of(:name).case_insensitive
  }
  it { should validate_presence_of(:price) }
  it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
end

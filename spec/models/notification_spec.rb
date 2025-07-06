require 'rails_helper'

describe Notification, type: :model do
  it { should belong_to(:project_manager) }
  it { should belong_to(:project) }
  it { should validate_presence_of(:message) }
  it { should validate_presence_of(:project_manager) }
  it { should validate_presence_of(:project) }

  describe 'scopes' do
    let!(:unread) { create(:notification, read_at: nil) }
    let!(:read) { create(:notification, read_at: Time.current) }

    it 'returns unread notifications' do
      expect(Notification.unread).to include(unread)
      expect(Notification.unread).not_to include(read)
    end

    it 'returns read notifications' do
      expect(Notification.read).to include(read)
      expect(Notification.read).not_to include(unread)
    end
  end

  describe '#mark_as_read!' do
    it 'sets read_at to current time' do
      notification = create(:notification, read_at: nil)
      notification.mark_as_read!
      expect(notification.read_at).to be_present
    end
  end

  describe '#read?' do
    it 'returns true if read_at is present' do
      notification = build(:notification, read_at: Time.current)
      expect(notification.read?).to be true
    end
    it 'returns false if read_at is nil' do
      notification = build(:notification, read_at: nil)
      expect(notification.read?).to be false
    end
  end
end 
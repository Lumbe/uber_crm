require 'rails_helper'

RSpec.describe Notification, type: :model do
  it "has a valid factory" do
    notification = build(:notification)
    expect(notification).to be_valid
  end
end

describe Notification do
  it { is_expected.to belong_to(:recipient) }
  it { is_expected.to belong_to(:actor) }
  it { is_expected.to belong_to(:notifiable) }
end
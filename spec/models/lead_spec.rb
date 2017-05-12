require 'rails_helper'

RSpec.describe Lead, type: :model do
  it 'has a valid lead factory' do
    lead = build(:lead)
    expect(lead).to be_valid
  end
end

describe Lead do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:phone) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:department) }
end
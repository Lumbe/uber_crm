require 'rails_helper'

RSpec.describe Membership, type: :model do
  it 'has a valid factory' do
    membership = build(:membership)
    expect(membership).to be_valid
  end
end

describe Membership do
  it { is_expected.to belong_to(:department) }
  it { is_expected.to belong_to(:user) }
end
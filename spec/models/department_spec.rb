require 'rails_helper'

RSpec.describe Department, type: :model do
  it "has a valid department factory" do
    department = build(:department)
    expect(department).to be_valid
  end
end

describe Department do
  it { is_expected.to have_many(:memberships) }
  it { is_expected.to have_many(:users) }
  it { is_expected.to have_many(:leads) }
  it { is_expected.to have_many(:contacts) }
end
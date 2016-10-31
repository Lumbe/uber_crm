require 'rails_helper'

RSpec.describe Contact, type: :model do
  it "has a valid factory" do
    contact = build(:contact)
    expect(contact).to be_valid
  end
end

describe Contact do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:phone) }
  it { is_expected.to validate_presence_of(:source) }
  it { is_expected.to validate_presence_of(:region) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:department) }
  it { is_expected.to have_many(:comments) }
end
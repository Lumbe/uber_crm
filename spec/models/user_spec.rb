require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has a valid user factory' do
    user = build(:user)
    expect(user).to be_valid
  end
  it 'has a valid admin factory' do
    admin = build(:admin)
    expect(admin).to be_valid
  end
end

describe User do
  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:last_name) }
end

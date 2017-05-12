require 'rails_helper'

RSpec.describe CommercialProposal, type: :model do
  it 'has a valid factory' do
    commercial_proposal = build(:commercial_proposal)
    expect(commercial_proposal).to be_valid
  end

  it { is_expected.to validate_presence_of(:project_name) }
  it { is_expected.to validate_presence_of(:house_kit_price) }
  it { is_expected.to validate_presence_of(:additional_services_price) }
  it { is_expected.to validate_presence_of(:dollar_exchange_rate) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:contact) }
end

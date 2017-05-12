# == Schema Information
#
# Table name: commercial_proposals
#
#  id                        :integer          not null, primary key
#  project_name              :string
#  house_kit_price           :decimal(8, 2)
#  additional_services_price :decimal(8, 2)
#  contact_id                :integer
#  user_id                   :integer
#  discount                  :decimal(8, 2)
#  dollar_exchange_rate      :decimal(5, 2)
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  project_url               :string
#  house_installation_price  :decimal(8, 2)
#  house_square              :decimal(8, 2)
#

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

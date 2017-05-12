# == Schema Information
#
# Table name: messages
#
#  id                     :integer          not null, primary key
#  from                   :string
#  to                     :string
#  subject                :string
#  body                   :string           default("")
#  message_id             :string
#  delivered_at           :datetime
#  opened_at              :datetime
#  user_id                :integer
#  commercial_proposal_id :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  inbound                :boolean          default(FALSE)
#

require 'rails_helper'

RSpec.describe Message, type: :model do
  it 'has a valid factory' do
    message = build(:message)
    expect(message).to be_valid
  end

  it 'has default subject if it is nil' do
    message = create :message
    expect(message.subject).to eq '(Без темы)'
  end

  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:commercial_proposal) }
  it { is_expected.to have_many(:attachments) }

  it { is_expected.to accept_nested_attributes_for(:attachments) }

  it { is_expected.to validate_presence_of(:from) }
  it { is_expected.to validate_presence_of(:to) }
  it { is_expected.to validate_presence_of(:user_id) }
end

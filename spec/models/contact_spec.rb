# == Schema Information
#
# Table name: contacts
#
#  id             :integer          not null, primary key
#  name           :string
#  user_id        :integer
#  customer_id    :integer
#  assigned_to    :integer
#  phone          :string
#  email          :string
#  location       :string
#  project        :string
#  square         :string
#  floor          :string
#  question       :string
#  region         :string
#  source         :string
#  online_request :boolean
#  come_in_office :boolean
#  phone_call     :boolean
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  department_id  :integer
#  status         :integer          default("newly")
#  proposal_sent  :datetime
#  alt_email      :string
#  do_not_call    :boolean          default(FALSE)
#

require 'rails_helper'

RSpec.describe Contact, type: :model do
  it 'has a valid factory' do
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

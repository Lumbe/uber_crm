# == Schema Information
#
# Table name: leads
#
#  id             :integer          not null, primary key
#  name           :string
#  phone          :string
#  email          :string
#  location       :string
#  project        :string
#  square         :string
#  floor          :string
#  question       :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  region         :string
#  source         :string
#  online_request :boolean          default(FALSE)
#  come_in_office :boolean          default(FALSE)
#  phone_call     :boolean          default(FALSE)
#  status         :integer          default("newly")
#  user_id        :integer
#  customer_id    :integer
#  assigned_to    :integer
#  department_id  :integer
#  contact_id     :integer
#

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

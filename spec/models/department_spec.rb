# == Schema Information
#
# Table name: departments
#
#  id                  :integer          not null, primary key
#  name                :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  avatar_file_name    :string
#  avatar_content_type :string
#  avatar_file_size    :integer
#  avatar_updated_at   :datetime
#  city                :string           default("")
#  address             :string           default("")
#  facebook            :string           default("")
#  vkontakte           :string           default("")
#  website             :string           default("")
#  email               :string           default("")
#

require 'rails_helper'

RSpec.describe Department, type: :model do
  it 'has a valid department factory' do
    department = build(:department)
    expect(department).to be_valid
  end

  it { is_expected.to have_many(:memberships) }
  it { is_expected.to have_many(:users) }
  it { is_expected.to have_many(:leads) }
  it { is_expected.to have_many(:contacts) }
  it { is_expected.to have_attached_file(:avatar) }
  it { is_expected.to validate_attachment_content_type(:avatar)
    .allowing('image/png', 'image/jpg', 'image/jpeg')
    .rejecting('text/html', 'text/xml', 'application/octet-stream', 'application/exe')}
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:city) }
  it { is_expected.to validate_presence_of(:address) }
  it { is_expected.to validate_presence_of(:email) }
end

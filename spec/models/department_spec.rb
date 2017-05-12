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
  it { is_expected.to validate_attachment_content_type(:avatar).
                allowing('image/png', 'image/jpg', 'image/jpeg').
                rejecting('text/html', 'text/xml', 'application/octet-stream', 'application/exe')}
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:city) }
  it { is_expected.to validate_presence_of(:address) }
  it { is_expected.to validate_presence_of(:email) }
end

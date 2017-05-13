# == Schema Information
#
# Table name: attachments
#
#  id                      :integer          not null, primary key
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  message_id              :integer
#  attachment_file_name    :string
#  attachment_content_type :string
#  attachment_file_size    :integer
#  attachment_updated_at   :datetime
#

require 'rails_helper'

RSpec.describe Attachment, type: :model do
  it {is_expected.to belong_to(:message)}
  it {is_expected.to have_attached_file(:attachment)}

  describe 'validate document file name with allowed formats' do
    context 'with valid file format' do
      Attachment::ALLOWED_FORMATS.each do |format|
        it { is_expected.to allow_value("file.#{format}").for(:attachment_file_name) }
      end
    end

    context 'with invalid file format' do
      unallowed_formats = %w(exe bat msi js cmd application)
      unallowed_formats.each do |format|
        it { is_expected.to_not allow_value("file.#{format}").for(:attachment_file_name) }
      end
    end
  end
end

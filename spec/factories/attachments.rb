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

FactoryGirl.define do
  factory :attachment do
    message
    attachment { File.new("#{Rails.root}/spec/support/fixtures/image.jpg") }
  end
  factory :invalid_attachment, class: 'Attachment' do
    message
    attachment { File.new("#{Rails.root}/spec/support/fixtures/image.exe") }
  end
end

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

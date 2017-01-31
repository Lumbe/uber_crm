FactoryGirl.define do
  factory :message do
    from      { Faker::Internet.email }
    to      { Faker::Internet.email }
    user
  end
  factory :invalid_message, class: 'Message' do
    from      { nil }
    to        { nil }
    user      { nil }
  end
end

FactoryGirl.define do
  factory :contact, class: Contact do
    name              { Faker::Name.name }
    user
    assignee          { user }
    phone             { Faker::PhoneNumber.phone_number }
    email             { Faker::Internet.email }
    location          { Faker::Address.city }
    project           { Faker::Space.galaxy }
    square            { Faker::Number.between(17, 333) }
    question          { Faker::Lorem.sentence }
    created_at        { Faker::Date.between(3.days.ago, Date.today) }
    region            { Faker::Address.state }
    source            { Faker::Address.ad_source }
    online_request    { Faker::Boolean.boolean }
    come_in_office    { Faker::Boolean.boolean }
    phone_call        { Faker::Boolean.boolean }
    department
  end
  factory :invalid_contact, class: Contact do
    name              { "" }
    user
    assignee          { user }
    phone             { "" }
    email             { Faker::Internet.email }
    location          { Faker::Address.city }
    project           { Faker::Space.galaxy }
    square            { Faker::Number.between(17, 333) }
    question          { Faker::Lorem.sentence }
    created_at        { Faker::Date.between(3.days.ago, Date.today) }
    region            { "" }
    source            { "" }
    online_request    { Faker::Boolean.boolean }
    come_in_office    { Faker::Boolean.boolean }
    phone_call        { Faker::Boolean.boolean }
  end
end

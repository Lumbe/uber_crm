FactoryGirl.define do
  factory :lead, class: Lead do
    name              { Faker::Name.name }
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
    user
    assignee
    department
  end
  factory :invalid_lead, class: Lead do
    name              ""
    phone             ""
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
    user
    assignee
    department
  end
end
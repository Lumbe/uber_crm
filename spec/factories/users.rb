FactoryGirl.define do
  factory :admin, class: User do
    first_name            { Faker::Name.first_name }
    last_name             { Faker::Name.last_name }
    created_at            { Faker::Date.backward(14) }
    email                 { Faker::Internet.email }
    password              { Faker::Internet.password(10, 20) }
    admin                 true
    phone                 { Faker::PhoneNumber.cell_phone }
  end
  factory :user, aliases: [:assignee] do
    first_name            { Faker::Name.first_name }
    last_name             { Faker::Name.last_name }
    created_at            { Faker::Date.backward(14) }
    email                 { Faker::Internet.email }
    password              { Faker::Internet.password(10, 20) }
    phone                 { Faker::PhoneNumber.cell_phone }
  end
end
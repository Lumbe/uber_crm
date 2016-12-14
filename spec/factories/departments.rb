FactoryGirl.define do
  factory :department do
    name              { Faker::Company.name }
    city              { Faker::Address.city }
    address           { Faker::Address.street_address }
    email             { Faker::Internet.email }
  end
end

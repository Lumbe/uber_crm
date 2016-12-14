FactoryGirl.define do
  factory :commercial_proposal, class: CommercialProposal do
    project_name                { Faker::Name.name }
    house_square                { Faker::Number.between(20, 300) }
    project_url                 { Faker::Internet.url }
    house_kit_price             { Faker::Number.between(4000, 15000) }
    house_installation_price    { Faker::Number.between(1000, 8000) }
    additional_services_price   { Faker::Number.between(5000, 16000) }
    association :contact, factory: :contact
    association :user, factory: :user
    discount                    { Faker::Number.between(5, 20) }
    dollar_exchange_rate        { Faker::Number.between(20, 30) }
  end
  factory :invalid_commercial_proposal, class: CommercialProposal do
    project_name                { nil }
    house_kit_price             { nil }
    additional_services_price   { nil }
    association :contact, factory: :contact
    association :user, factory: :user
    discount                    { Faker::Number.between(5, 20) }
    dollar_exchange_rate        { nil }
  end
end

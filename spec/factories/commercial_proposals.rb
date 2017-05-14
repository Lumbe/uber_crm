# == Schema Information
#
# Table name: commercial_proposals
#
#  id                        :integer          not null, primary key
#  project_name              :string
#  house_kit_price           :decimal(8, 2)
#  additional_services_price :decimal(8, 2)
#  contact_id                :integer
#  user_id                   :integer
#  discount                  :decimal(8, 2)
#  dollar_exchange_rate      :decimal(5, 2)
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  project_url               :string
#  house_installation_price  :decimal(8, 2)
#  house_square              :decimal(8, 2)
#

FactoryGirl.define do
  factory :commercial_proposal, class: CommercialProposal do
    project_name                { Faker::Name.name }
    house_square                { Faker::Number.between(20, 300) }
    project_url                 { Faker::Internet.url }
    house_kit_price             { Faker::Number.between(4000, 15_000) }
    house_installation_price    { Faker::Number.between(1000, 8000) }
    additional_services_price   { Faker::Number.between(5000, 16_000) }
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

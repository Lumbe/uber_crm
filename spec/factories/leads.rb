# == Schema Information
#
# Table name: leads
#
#  id             :integer          not null, primary key
#  name           :string
#  phone          :string
#  email          :string
#  location       :string
#  project        :string
#  square         :string
#  floor          :string
#  question       :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  region         :string
#  source         :string
#  online_request :boolean          default(FALSE)
#  come_in_office :boolean          default(FALSE)
#  phone_call     :boolean          default(FALSE)
#  status         :integer          default("newly")
#  user_id        :integer
#  customer_id    :integer
#  assigned_to    :integer
#  department_id  :integer
#  contact_id     :integer
#

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
    name              ''
    phone             ''
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

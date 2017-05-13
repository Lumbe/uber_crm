# == Schema Information
#
# Table name: contacts
#
#  id             :integer          not null, primary key
#  name           :string
#  user_id        :integer
#  customer_id    :integer
#  assigned_to    :integer
#  phone          :string
#  email          :string
#  location       :string
#  project        :string
#  square         :string
#  floor          :string
#  question       :string
#  region         :string
#  source         :string
#  online_request :boolean
#  come_in_office :boolean
#  phone_call     :boolean
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  department_id  :integer
#  status         :integer          default("newly")
#  proposal_sent  :datetime
#  alt_email      :string
#  do_not_call    :boolean          default(FALSE)
#

FactoryGirl.define do
  factory :contact, class: Contact do
    name { Faker::Name.name }
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
    name { '' }
    user
    assignee          { user }
    phone             { '' }
    email             { Faker::Internet.email }
    location          { Faker::Address.city }
    project           { Faker::Space.galaxy }
    square            { Faker::Number.between(17, 333) }
    question          { Faker::Lorem.sentence }
    created_at        { Faker::Date.between(3.days.ago, Date.today) }
    region            { '' }
    source            { '' }
    online_request    { Faker::Boolean.boolean }
    come_in_office    { Faker::Boolean.boolean }
    phone_call        { Faker::Boolean.boolean }
  end
end

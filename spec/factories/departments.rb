# == Schema Information
#
# Table name: departments
#
#  id                  :integer          not null, primary key
#  name                :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  avatar_file_name    :string
#  avatar_content_type :string
#  avatar_file_size    :integer
#  avatar_updated_at   :datetime
#  city                :string           default("")
#  address             :string           default("")
#  facebook            :string           default("")
#  vkontakte           :string           default("")
#  website             :string           default("")
#  email               :string           default("")
#

FactoryGirl.define do
  factory :department do
    name              { Faker::Company.name }
    city              { Faker::Address.city }
    address           { Faker::Address.street_address }
    email             { Faker::Internet.email }
  end
end

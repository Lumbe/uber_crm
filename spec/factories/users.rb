# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  first_name             :string           default(""), not null
#  last_name              :string           default(""), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  admin                  :boolean          default(FALSE)
#  phone                  :string
#  skype                  :string
#  avatar_file_name       :string
#  avatar_content_type    :string
#  avatar_file_size       :integer
#  avatar_updated_at      :datetime
#  current_department_id  :integer
#  current_role           :string           default("")
#

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

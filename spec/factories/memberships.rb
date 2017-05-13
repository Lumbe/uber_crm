# == Schema Information
#
# Table name: memberships
#
#  id            :integer          not null, primary key
#  department_id :integer
#  user_id       :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  role          :integer          default("visitor")
#

FactoryGirl.define do
  factory :membership do
    department
    user
    role { Membership.roles.keys.sample }
  end
end

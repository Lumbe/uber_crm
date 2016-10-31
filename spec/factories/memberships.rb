FactoryGirl.define do
  factory :membership do
    department
    user
    role  { Membership.roles.keys.sample }
  end
end

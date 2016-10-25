FactoryGirl.define do
  factory :comment do
    user
    association :commentable, factory: :contact
  end
end

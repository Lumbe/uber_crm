FactoryGirl.define do
  factory :notification do
    association :recipient, factory: :user
    association :actor, factory: :user
    association :notifiable, factory: [:lead, :contact].sample
    action      "добавил"
  end
end

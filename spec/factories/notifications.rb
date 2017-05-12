# == Schema Information
#
# Table name: notifications
#
#  id                :integer          not null, primary key
#  recipient_id      :integer
#  actor_id          :integer
#  read_at           :datetime
#  action            :string
#  notifiable_id     :integer
#  notifiable_type   :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  notification_type :integer          default("general")
#

FactoryGirl.define do
  factory :notification do
    association :recipient, factory: :user
    association :actor, factory: :user
    association :notifiable, factory: [:lead, :contact].sample
    action      'добавил'
  end
end

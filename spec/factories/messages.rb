# == Schema Information
#
# Table name: messages
#
#  id                     :integer          not null, primary key
#  from                   :string
#  to                     :string
#  subject                :string
#  body                   :string           default("")
#  message_id             :string
#  delivered_at           :datetime
#  opened_at              :datetime
#  user_id                :integer
#  commercial_proposal_id :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  inbound                :boolean          default(FALSE)
#

FactoryGirl.define do
  factory :message do
    from { Faker::Internet.email }
    to { Faker::Internet.email }
    user
  end
  factory :invalid_message, class: 'Message' do
    from      { nil }
    to        { nil }
    user      { nil }
  end
end

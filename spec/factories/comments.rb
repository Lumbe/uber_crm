# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  commentable_id   :integer
#  commentable_type :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  body             :text
#  comment_type     :integer          default("message")
#

FactoryGirl.define do
  factory :comment do
    user
    association :commentable, factory: :contact
  end
end

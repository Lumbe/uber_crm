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

require 'rails_helper'

RSpec.describe Comment, type: :model do
  it 'has a valid factory' do
    comment = build(:comment)
    expect(comment).to be_valid
  end

  it { is_expected.to belong_to(:user) }

  it { is_expected.to belong_to(:commentable) }
end

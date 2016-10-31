require 'rails_helper'

RSpec.describe Comment, type: :model do
  it "has a valid factory" do
    comment = build(:comment)
    expect(comment).to be_valid
  end
end

describe Comment do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:commentable) }
end
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

class Comment < ApplicationRecord
  enum comment_type: [:message, :commercial_prop, :phone_call, :new_lead]

  belongs_to :user
  belongs_to :commentable, polymorphic: true

end

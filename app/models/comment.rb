class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true

  enum comment_type: [:message, :commercial_prop, :phone_call, :new_lead]
end

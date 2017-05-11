class Comment < ApplicationRecord
  enum comment_type: [:message, :commercial_prop, :phone_call, :new_lead]

  belongs_to :user
  belongs_to :commentable, polymorphic: true

end

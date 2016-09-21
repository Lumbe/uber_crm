class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :commentable, polymorphic: true

  enum comment_type: [:message, :commercial_prop]
end

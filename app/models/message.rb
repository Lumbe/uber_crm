class Message < ApplicationRecord
  belongs_to :user
  belongs_to :commercial_proposal, optional: true
end

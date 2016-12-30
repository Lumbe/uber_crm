class Message < ApplicationRecord
  before_save do
    self.subject = '(Без темы)' if subject.blank?
  end

  belongs_to :user
  belongs_to :commercial_proposal, optional: true

  validates_presence_of :from, :to, :user_id
end

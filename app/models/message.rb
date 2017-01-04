class Message < ApplicationRecord
  before_save do
    self.subject = '(Без темы)' if subject.blank?
  end

  belongs_to :user
  belongs_to :commercial_proposal, optional: true
  has_many :attachments, dependent: :destroy

  validates_presence_of :from, :to, :user_id

  # def mail_attachments=(files)
  #   files.each do |file|
  #     attachments.build(attachment: file)
  #   end
  # end
end

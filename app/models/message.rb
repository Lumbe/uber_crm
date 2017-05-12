# == Schema Information
#
# Table name: messages
#
#  id                     :integer          not null, primary key
#  from                   :string
#  to                     :string
#  subject                :string
#  body                   :string           default("")
#  message_id             :string
#  delivered_at           :datetime
#  opened_at              :datetime
#  user_id                :integer
#  commercial_proposal_id :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  inbound                :boolean          default(FALSE)
#

class Message < ApplicationRecord
  before_save do
    self.subject = '(Без темы)' if subject.blank?
  end

  belongs_to :user
  belongs_to :commercial_proposal, optional: true
  has_many :attachments, dependent: :destroy, inverse_of: :message
  accepts_nested_attributes_for :attachments

  validates_presence_of :from, :to, :user_id

  # def mail_attachments=(files)
  #   files.each do |file|
  #     attachments.build(attachment: file)
  #   end
  # end
end

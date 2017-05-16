# == Schema Information
#
# Table name: notifications
#
#  id                :integer          not null, primary key
#  recipient_id      :integer
#  actor_id          :integer
#  read_at           :datetime
#  action            :string
#  notifiable_id     :integer
#  notifiable_type   :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  notification_type :integer          default("general")
#

class Notification < ApplicationRecord
  enum notification_type: [:general, :message]

  belongs_to :recipient, class_name: 'User'
  belongs_to :actor, class_name: 'User'
  belongs_to :notifiable, polymorphic: true

  scope :unread, -> { where(read_at: nil) }
end

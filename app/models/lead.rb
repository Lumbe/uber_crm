# == Schema Information
#
# Table name: leads
#
#  id             :integer          not null, primary key
#  name           :string
#  phone          :string
#  email          :string
#  location       :string
#  project        :string
#  square         :string
#  floor          :string
#  question       :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  region         :string
#  source         :string
#  online_request :boolean          default(FALSE)
#  come_in_office :boolean          default(FALSE)
#  phone_call     :boolean          default(FALSE)
#  status         :integer          default("newly")
#  user_id        :integer
#  customer_id    :integer
#  assigned_to    :integer
#  department_id  :integer
#  contact_id     :integer
#

class Lead < ApplicationRecord
  include PublicActivity::Common

  enum status: [:newly, :closed, :converted, :sended, :repeated, :claimed]

  belongs_to :user
  belongs_to :assignee, class_name: 'User', foreign_key: :assigned_to, optional: true
  belongs_to :contact, optional: true
  belongs_to :customer, optional: true
  belongs_to :department
  has_many :comments, as: :commentable

  validates :name, :phone, presence: true

  phony_normalize :phone, default_country_code: 'UA'

  scope :order_by_status, -> (first = :claimed, second = :repeated, third = :newly, fourth = :converted, fifth = :sended, sixth = :closed) {
    order("status = #{Lead.statuses[first]} DESC, status = #{Lead.statuses[second]} DESC, status = #{Lead.statuses[third]} DESC,
    status = #{Lead.statuses[fourth]} DESC, status = #{Lead.statuses[fifth]} DESC, status = #{Lead.statuses[sixth]} DESC")
    }

  def related_contacts
    Contact.where(department: department).ransack(phone_cont: phone.chars.last(7).join).result.or(Contact.where(department: department, email: email).where.not(email: ''))
  end

end

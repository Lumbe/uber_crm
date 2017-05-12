# == Schema Information
#
# Table name: contacts
#
#  id             :integer          not null, primary key
#  name           :string
#  user_id        :integer
#  customer_id    :integer
#  assigned_to    :integer
#  phone          :string
#  email          :string
#  location       :string
#  project        :string
#  square         :string
#  floor          :string
#  question       :string
#  region         :string
#  source         :string
#  online_request :boolean
#  come_in_office :boolean
#  phone_call     :boolean
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  department_id  :integer
#  status         :integer          default("newly")
#  proposal_sent  :datetime
#  alt_email      :string
#  do_not_call    :boolean          default(FALSE)
#

class Contact < ApplicationRecord
  include PublicActivity::Common

  enum status: [:newly, :repeated, :proposal, :finished, :sended]

  belongs_to :user
  belongs_to :assignee, class_name: 'User', foreign_key: :assigned_to, optional: true
  belongs_to :customer, optional: true
  belongs_to :department
  has_many :leads
  has_many :comments, as: :commentable
  has_many :commercial_proposals

  validates :name, :phone, :source, :region, presence: true

  phony_normalize :phone, default_country_code: 'UA'

  scope :order_by_status, -> (first = :proposal, second = :repeated, third = :newly, fourth = :finished, fifth = :sended) {
    order("status = #{Contact.statuses[first]} DESC, status = #{Contact.statuses[second]} DESC, status = #{Contact.statuses[third]} DESC, status = #{Contact.statuses[fourth]} DESC")
    }

  def self.top_repeated_leads
    joins(:leads).group('contacts.id').order('count(leads.id) DESC')
  end

end

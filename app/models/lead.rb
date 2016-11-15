class Lead < ApplicationRecord
  include PublicActivity::Common

  belongs_to :user
  belongs_to :assignee, class_name: "User", foreign_key: :assigned_to, optional: true
  belongs_to :contact, optional: true
  belongs_to :customer, optional: true
  belongs_to :department
  has_many :comments, as: :commentable
  has_many :messages, class_name: "Ahoy::Message"
  validates :name, :phone, presence: true
  phony_normalize :phone, default_country_code: 'UA'

  enum status: [:newly, :closed, :converted, :sended, :repeated, :claimed]
  
  scope :order_by_status, -> (first = :claimed, second = :repeated, third = :newly, fourth = :converted, fifth = :sended, sixth = :closed) {
    order("status = #{Lead.statuses[first]} DESC, status = #{Lead.statuses[second]} DESC, status = #{Lead.statuses[third]} DESC,
    status = #{Lead.statuses[fourth]} DESC, status = #{Lead.statuses[fifth]} DESC, status = #{Lead.statuses[sixth]} DESC")
    }

  # @return [Array<Array>]
  def self.status_attributes_for_select
    statuses.map do |status, _|
      [I18n.t("activerecord.attributes.#{model_name.i18n_key}.statuses.#{status}"), status]
    end
  end

  def contact_exists?
    Contact.where(department: self.department, phone: self.phone).or(Contact.where(department: self.department, email: self.email).where.not(email: '')).exists? ? true : false
  end

  def related_contacts
    Contact.where(department: self.department, phone: self.phone).or(Contact.where(department: self.department, email: self.email).where.not(email: ''))
  end

end

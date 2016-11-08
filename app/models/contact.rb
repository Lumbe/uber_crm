class Contact < ApplicationRecord
  include PublicActivity::Common

  belongs_to :user
  belongs_to :assignee, class_name: "User", foreign_key: :assigned_to, optional: true
  belongs_to :customer, optional: true
  belongs_to :department
  has_many :leads
  has_many :comments, as: :commentable
  phony_normalize :phone, default_country_code: 'UA'
  validates :name, :phone, :source, :region, presence: true

  enum status: [:newly, :repeated, :proposal, :finished, :sended]
  
  scope :order_by_status, -> (first = :proposal, second = :repeated, third = :newly, fourth = :finished, fifth = :sended) {
    order("status = #{Contact.statuses[first]} DESC, status = #{Contact.statuses[second]} DESC, status = #{Contact.statuses[third]} DESC, status = #{Contact.statuses[fourth]} DESC")
    }

  # @return [Array<Array>]
  def self.status_attributes_for_select
    statuses.map do |status, _|
      [I18n.t("activerecord.attributes.#{model_name.i18n_key}.statuses.#{status}"), status]
    end
  end

  def lead_exists?
    Lead.where(department: self.department, phone: self.phone).or(Lead.where(department: self.department, email: self.email).where.not(email: '')).exists? ? true : false
  end

  def related_leads
    Lead.where(department: self.department, phone: self.phone).or(Lead.where(department: self.department, email: self.email).where.not(email: ''))
  end

end

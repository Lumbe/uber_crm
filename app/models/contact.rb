class Contact < ApplicationRecord
  include PublicActivity::Common

  enum status: [:newly, :repeated, :proposal, :finished, :sended]

  belongs_to :user
  belongs_to :assignee, class_name: "User", foreign_key: :assigned_to, optional: true
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

  # @return [Array<Array>]
  def self.status_attributes_for_select
    statuses.map do |status, _|
      [I18n.t("activerecord.attributes.#{model_name.i18n_key}.statuses.#{status}"), status]
    end
  end

  def self.top_repeated_leads
    joins(:leads).group("contacts.id").order("count(leads.id) DESC")
  end

end

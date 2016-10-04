class Lead < ApplicationRecord
  belongs_to :user
  belongs_to :assignee, class_name: "User", foreign_key: :assigned_to
  belongs_to :contact
  belongs_to :customer
  belongs_to :department
  has_many :comments, as: :commentable
  validates :name, :phone, presence: true

  enum status: [:newly, :closed, :converted, :sended, :repeated, :claimed]
  
  # @return [Array<Array>]
  def self.status_attributes_for_select
    statuses.map do |status, _|
      [I18n.t("activerecord.attributes.#{model_name.i18n_key}.statuses.#{status}"), status]
    end
  end

end

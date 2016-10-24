class Contact < ApplicationRecord
  belongs_to :user
  belongs_to :assignee, class_name: "User", foreign_key: :assigned_to, optional: true
  belongs_to :customer, optional: true
  belongs_to :department
  has_many :leads
  has_many :comments, as: :commentable
  validates :name, :phone, :source, :region, presence: true
  
  enum status: [:newly, :repeated, :proposal, :finished]
  
  scope :order_by_status, -> (first = :proposal, second = :repeated, third = :newly, fourth = :finished) {
    order("status = #{Contact.statuses[first]} DESC, status = #{Contact.statuses[second]} DESC, status = #{Contact.statuses[third]} DESC, status = #{Contact.statuses[fourth]} DESC")
    }

end

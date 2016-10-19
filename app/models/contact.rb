class Contact < ApplicationRecord
  belongs_to :user
  belongs_to :assignee, class_name: "User", foreign_key: :assigned_to, optional: true
  belongs_to :customer, optional: true
  belongs_to :department
  has_many :leads
  has_many :comments, as: :commentable
  
  enum status: [:newly, :repeated, :proposal, :finished]
  
  validates :name, :phone, :source, :region, presence: true

end

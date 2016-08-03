class Customer < ActiveRecord::Base
  belongs_to :user
  belongs_to :assignee, class_name: "User", foreign_key: :assigned_to
  belongs_to :department
  has_many :comments, as: :commentable
  has_many :leads
  has_many :contacts
end

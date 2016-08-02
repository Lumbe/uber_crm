class Customer < ActiveRecord::Base
  belongs_to :user
  belongs_to :assignee, class_name: "User", foreign_key: :assigned_to
  has_many :comments, as: :commentable
  has_many :leads
  has_many :contacts
end

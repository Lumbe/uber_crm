class Department < ActiveRecord::Base
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  has_many :leads
  has_many :contacts
  has_many :customers
  has_many :competitors
end

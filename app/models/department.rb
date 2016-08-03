class Department < ActiveRecord::Base
  has_many :users
  has_many :leads
  has_many :contacts
  has_many :customers
  has_many :competitors
end

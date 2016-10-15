class Department < ApplicationRecord
  
  class_attribute :current
  
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  has_many :leads
  has_many :contacts
  has_many :customers
  has_many :competitors
  
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/assets/missing_avatar.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
end

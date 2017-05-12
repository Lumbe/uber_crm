# == Schema Information
#
# Table name: departments
#
#  id                  :integer          not null, primary key
#  name                :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  avatar_file_name    :string
#  avatar_content_type :string
#  avatar_file_size    :integer
#  avatar_updated_at   :datetime
#  city                :string           default("")
#  address             :string           default("")
#  facebook            :string           default("")
#  vkontakte           :string           default("")
#  website             :string           default("")
#  email               :string           default("")
#

class Department < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  has_many :leads
  has_many :contacts
  has_many :customers
  has_many :competitors

  has_attached_file :avatar, styles: { medium: '300x300>', thumb: '100x100>' }, default_url: '/assets/missing_avatar.png'
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  validates :name, :city, :address, :email, presence: true
end

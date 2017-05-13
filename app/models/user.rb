# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  first_name             :string           default(""), not null
#  last_name              :string           default(""), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  admin                  :boolean          default(FALSE)
#  phone                  :string
#  skype                  :string
#  avatar_file_name       :string
#  avatar_content_type    :string
#  avatar_file_size       :integer
#  avatar_updated_at      :datetime
#  current_department_id  :integer
#  current_role           :string           default("")
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :memberships, dependent: :destroy
  has_many :departments, through: :memberships
  has_many :leads
  has_many :contacts
  has_many :customers
  has_many :competitors
  has_many :comments, as: :commentable # As owner who created a comment.
  has_many :notifications, foreign_key: :recipient_id
  has_many :commercial_proposals
  has_many :messages

  has_attached_file :avatar, styles: { big: '300x300>', medium: '150x150>', thumb: '40x40>' }, default_url: 'missing_avatar_:style.png'
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  validates :first_name, :last_name, :phone, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end

end

class User < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :departments, through: :memberships
  has_many :leads
  has_many :contacts
  has_many :customers
  has_many :competitors
  has_many :comments, as: :commentable      # As owner who created a comment.
  has_many :notifications, foreign_key: :recipient_id

  has_attached_file :avatar, styles: { big: "300x300>", medium: "150x150>", thumb: "40x40>" }, default_url: "missing_avatar_:style.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, :last_name, presence: true

end

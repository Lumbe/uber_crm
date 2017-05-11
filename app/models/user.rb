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
  has_many :comments, as: :commentable      # As owner who created a comment.
  has_many :notifications, foreign_key: :recipient_id
  has_many :commercial_proposals
  has_many :messages

  has_attached_file :avatar, styles: { big: "300x300>", medium: "150x150>", thumb: "40x40>" }, default_url: "missing_avatar_:style.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  validates :first_name, :last_name, :phone, presence: true
  
  def full_name
    "#{first_name} #{last_name}"
  end

end

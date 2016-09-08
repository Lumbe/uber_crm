class User < ActiveRecord::Base
  has_many :memberships, dependent: :destroy
  has_many :departments, through: :memberships
  has_many :leads
  has_many :contacts
  has_many :customers
  has_many :competitors
  has_many :comments, as: :commentable      # As owner who created a comment.

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/assets/missing_avatar.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, :last_name, presence: true
end

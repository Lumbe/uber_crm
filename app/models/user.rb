class User < ActiveRecord::Base
  has_many :leads
  has_many :contacts
  has_many :customers
  has_many :competitors
  has_many :comments, as: :commentable      # As owner who created a comment.

  enum role: [:visitor, :admin, :chief, :marketer, :senior_manager, :manager, :tech_designer, :estimator, :accountant]
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

end

class Lead < ActiveRecord::Base
  belongs_to :user
  belongs_to :assignee, class_name: "User", foreign_key: :assigned_to
  belongs_to :contact
  belongs_to :customer
  belongs_to :department
  has_many :comments, as: :commentable
  validates :name, :phone, presence: true

  enum status: [:newly, :closed, :converted, :sended, :repeated, :claimed]

end

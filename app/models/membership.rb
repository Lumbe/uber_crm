class Membership < ApplicationRecord
  enum role: [:visitor, :chief, :marketer, :senior_manager, :manager, :tech_designer, :estimator, :accountant, :retired]

  belongs_to :department
  belongs_to :user

end

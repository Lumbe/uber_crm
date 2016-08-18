class Membership < ActiveRecord::Base
  belongs_to :department
  belongs_to :user
  
  enum role: [:visitor, :chief, :marketer, :senior_manager, :manager, :tech_designer, :estimator, :accountant]
end

# == Schema Information
#
# Table name: memberships
#
#  id            :integer          not null, primary key
#  department_id :integer
#  user_id       :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  role          :integer          default("visitor")
#

class Membership < ApplicationRecord
  enum role: [:visitor, :chief, :marketer, :senior_manager, :manager, :tech_designer, :estimator, :accountant, :retired]

  belongs_to :department
  belongs_to :user

end

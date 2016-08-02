class User < ActiveRecord::Base
  enum role: [:visitor, :admin, :chief, :marketer, :senior_manager, :manager, :tech_designer, :estimator, :accountant]
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

end

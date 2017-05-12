# == Schema Information
#
# Table name: customers
#
#  id             :integer          not null, primary key
#  name           :string
#  user_id        :integer
#  assigned_to    :integer
#  phone          :string
#  email          :string
#  location       :string
#  project        :string
#  square         :string
#  floor          :string
#  question       :string
#  region         :string
#  source         :string
#  online_request :boolean
#  come_in_office :boolean
#  phone_call     :boolean
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  department_id  :integer
#

class Customer < ApplicationRecord
  belongs_to :user
  belongs_to :assignee, class_name: 'User', foreign_key: :assigned_to, optional: true
  belongs_to :department
  has_many :comments, as: :commentable
  has_many :leads
  has_many :contacts
end

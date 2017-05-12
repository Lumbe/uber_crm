# == Schema Information
#
# Table name: commercial_proposals
#
#  id                        :integer          not null, primary key
#  project_name              :string
#  house_kit_price           :decimal(8, 2)
#  additional_services_price :decimal(8, 2)
#  contact_id                :integer
#  user_id                   :integer
#  discount                  :decimal(8, 2)
#  dollar_exchange_rate      :decimal(5, 2)
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  project_url               :string
#  house_installation_price  :decimal(8, 2)
#  house_square              :decimal(8, 2)
#

class CommercialProposal < ApplicationRecord
  include PublicActivity::Common

  belongs_to :user
  belongs_to :contact
  has_many :messages

  validates :project_name, :house_square, :project_url, :house_kit_price,
            :house_installation_price, :additional_services_price,
            :dollar_exchange_rate,
            presence: true

end

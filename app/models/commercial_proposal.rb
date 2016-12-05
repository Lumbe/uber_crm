class CommercialProposal < ApplicationRecord
  belongs_to :user
  belongs_to :contact

  validates :project_name, :house_kit_price, :additional_services_price,
            :dollar_exchange_rate,
            presence: true

end

class CommercialProposal < ApplicationRecord
  belongs_to :user
  belongs_to :contact
  has_many :messages

  validates :project_name, :house_square, :project_url, :house_kit_price,
            :house_installation_price, :additional_services_price,
            :dollar_exchange_rate,
            presence: true

end

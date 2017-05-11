class ChangeDollarExchangeRatePrecisionInCommercialProposals < ActiveRecord::Migration[5.0]
  def change
    change_column :commercial_proposals, :dollar_exchange_rate, :decimal, precision: 5, scale: 2
  end
end

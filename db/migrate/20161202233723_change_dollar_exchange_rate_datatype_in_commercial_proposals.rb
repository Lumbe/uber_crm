class ChangeDollarExchangeRateDatatypeInCommercialProposals < ActiveRecord::Migration[5.0]
  def change
    change_column :commercial_proposals, :dollar_exchange_rate, :decimal
  end
end

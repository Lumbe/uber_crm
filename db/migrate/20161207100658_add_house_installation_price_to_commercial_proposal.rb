class AddHouseInstallationPriceToCommercialProposal < ActiveRecord::Migration[5.0]
  def change
    add_column :commercial_proposals, :house_installation_price, :decimal, precision: 8, scale: 2
  end
end

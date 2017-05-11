class ChangePricesColumnsDatatypesInCommercialProposal < ActiveRecord::Migration[5.0]
  def change
    change_column :commercial_proposals, :house_kit_price, :decimal, precision: 8, scale: 2
    change_column :commercial_proposals, :additional_services_price, :decimal, precision: 8, scale: 2
    change_column :commercial_proposals, :discount, :decimal, precision: 8, scale: 2
  end
end

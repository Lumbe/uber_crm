class AddHouseSquareToCommercialProposal < ActiveRecord::Migration[5.0]
  def change
    add_column :commercial_proposals, :house_square, :decimal, precision: 8, scale: 2
  end
end

class RemoveDeliveredAtOpenedAtFromCommercialProposals < ActiveRecord::Migration[5.0]
  def change
    remove_column :commercial_proposals, :delivered_at
    remove_column :commercial_proposals, :opened_at
  end
end

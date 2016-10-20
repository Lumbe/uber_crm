class AddProposalSentToContact < ActiveRecord::Migration[5.0]
  def change
    add_column :contacts, :proposal_sent, :datetime
  end
end

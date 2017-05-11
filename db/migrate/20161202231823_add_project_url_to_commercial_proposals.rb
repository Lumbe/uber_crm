class AddProjectUrlToCommercialProposals < ActiveRecord::Migration[5.0]
  def change
    add_column :commercial_proposals, :project_url, :string
  end
end

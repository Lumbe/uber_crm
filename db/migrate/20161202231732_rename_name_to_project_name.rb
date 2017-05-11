class RenameNameToProjectName < ActiveRecord::Migration[5.0]
  def change
    rename_column :commercial_proposals, :name, :project_name
  end
end

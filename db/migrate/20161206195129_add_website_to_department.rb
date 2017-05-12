class AddWebsiteToDepartment < ActiveRecord::Migration[5.0]
  def change
    add_column :departments, :website, :string, default: ''
  end
end

class AddCurrentRoleToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :current_role, :string, default: ''
  end
end

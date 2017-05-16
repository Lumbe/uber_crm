class AddRoleToMemberships < ActiveRecord::Migration
  def change
    add_column :memberships, :role, :integer, default: 0
  end
end

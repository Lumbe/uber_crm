class AddDepartmentIdToContact < ActiveRecord::Migration
  def change
    add_column :contacts, :department_id, :integer
  end
end

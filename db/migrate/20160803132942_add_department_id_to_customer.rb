class AddDepartmentIdToCustomer < ActiveRecord::Migration
  def change
    add_column :customers, :department_id, :integer
  end
end

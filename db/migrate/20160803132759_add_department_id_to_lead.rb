class AddDepartmentIdToLead < ActiveRecord::Migration
  def change
    add_column :leads, :department_id, :integer
  end
end

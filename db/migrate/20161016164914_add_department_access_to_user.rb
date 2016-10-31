class AddDepartmentAccessToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :current_department_id, :integer
  end
end

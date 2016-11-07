class AddTrackableDepartmentIdToActivity < ActiveRecord::Migration[5.0]
  def change
    add_column :activities, :trackable_department_id, :integer
  end
end

class AddDepartmentIdToCompetitor < ActiveRecord::Migration
  def change
    add_column :competitors, :department_id, :integer
  end
end

class AddEmailToDepartment < ActiveRecord::Migration[5.0]
  def change
    add_column :departments, :email, :string, default: ''
  end
end

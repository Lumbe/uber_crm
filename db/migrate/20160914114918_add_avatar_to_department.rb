class AddAvatarToDepartment < ActiveRecord::Migration
  def up
    add_attachment :departments, :avatar
  end

  def down
    remove_attachment :departments, :avatar
  end
end

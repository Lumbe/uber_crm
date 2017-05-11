class AddCityAddressFbVkToDepartment < ActiveRecord::Migration[5.0]
  def change
    add_column :departments, :city, :string, default: ""
    add_column :departments, :address, :string, default: ""
    add_column :departments, :facebook, :string, default: ""
    add_column :departments, :vkontakte, :string, default: ""
  end
end

class AddColumnsToUser < ActiveRecord::Migration
  def change
    add_column :users, :phone, :string
    add_column :users, :skype, :string
    change_column_default :users, :first_name, ''
    change_column_default :users, :last_name, ''
    change_column_null :users, :first_name, false
    change_column_null :users, :last_name, false
  end
end

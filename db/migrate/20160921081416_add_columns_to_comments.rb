class AddColumnsToComments < ActiveRecord::Migration
  def change
    add_column :comments, :body, :text
    add_column :comments, :type, :integer, :default => 0
  end
end

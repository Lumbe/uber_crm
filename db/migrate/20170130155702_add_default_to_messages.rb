class AddDefaultToMessages < ActiveRecord::Migration[5.0]
  def change
    change_column :messages, :body, :string, default: ""
  end
end

class AddInboundToMessages < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :inbound, :boolean, default: false
  end
end

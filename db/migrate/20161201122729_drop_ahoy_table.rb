class DropAhoyTable < ActiveRecord::Migration[5.0]
  def change
    drop_table :ahoy_messages
  end
end

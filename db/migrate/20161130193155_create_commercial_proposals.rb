class CreateCommercialProposals < ActiveRecord::Migration[5.0]
  def change
    create_table :commercial_proposals do |t|
      t.string :name
      t.integer :house_kit_price
      t.integer :additional_services_price
      t.integer :contact_id
      t.integer :user_id
      t.integer :discount
      t.integer :dollar_exchange_rate
      t.datetime :delivered_at
      t.datetime :opened_at

      t.timestamps
    end
  end
end

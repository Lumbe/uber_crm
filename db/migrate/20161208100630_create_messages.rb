class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.string :from
      t.string :to
      t.string :subject
      t.string :body
      t.string :message_id
      t.datetime :delivered_at
      t.datetime :opened_at
      t.integer :user_id
      t.integer :commercial_proposal_id

      t.timestamps
    end
  end
end

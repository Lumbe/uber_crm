class CreateCompetitors < ActiveRecord::Migration
  def change
    create_table :competitors do |t|
      t.string :name
      t.integer :user_id
      t.integer :assigned_to
      t.string :phone
      t.string :email
      t.string :location
      t.string :project
      t.string :square
      t.string :floor
      t.string :question
      t.string :region
      t.string :source
      t.boolean :online_request
      t.boolean :come_in_office
      t.boolean :phone_call

      t.timestamps null: false
    end
  end
end

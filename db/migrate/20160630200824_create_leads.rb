class CreateLeads < ActiveRecord::Migration
  def change
    create_table :leads do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.string :location
      t.string :project
      t.string :square
      t.string :floor
      t.text :question

      t.timestamps null: false
    end
  end
end

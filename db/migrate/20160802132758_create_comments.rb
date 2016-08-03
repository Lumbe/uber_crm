class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.references :commentable, polymorphic: true, index: true
      t.string :title
      t.text :comment

      t.timestamps null: false
    end
  end
end
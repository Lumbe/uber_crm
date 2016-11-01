class AddAltEmailDoNotCallDelegatedToContact < ActiveRecord::Migration[5.0]
  def change
    add_column :contacts, :alt_email, :string
    add_column :contacts, :do_not_call, :boolean, default: false
  end
end

class AddFieldsToLead < ActiveRecord::Migration
  def change
    add_column :leads, :source, :string
    add_column :leads, :online_request, :boolean, default: false
    add_column :leads, :come_in_office, :boolean, default: false
    add_column :leads, :phone_call, :boolean, default: false
  end
end

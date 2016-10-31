class RemoveContactIdFromLeads < ActiveRecord::Migration[5.0]
  def change
    remove_column :leads, :contact_id
  end
end

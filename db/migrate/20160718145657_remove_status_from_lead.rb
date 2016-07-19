class RemoveStatusFromLead < ActiveRecord::Migration
  def change
    remove_column :leads, :status
  end
end

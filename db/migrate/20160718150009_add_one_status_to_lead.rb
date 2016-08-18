class AddOneStatusToLead < ActiveRecord::Migration
  def change
    add_column :leads, :status, :integer, default: 0
  end
end

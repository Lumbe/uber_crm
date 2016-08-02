class AddAssignedtoToLead < ActiveRecord::Migration
  def change
    add_column :leads, :user_id, :integer
    add_column :leads, :contact_id, :integer
    add_column :leads, :customer_id, :integer
    add_column :leads, :assigned_to, :integer
  end
end

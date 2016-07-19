class AddRegionToLead < ActiveRecord::Migration
  def change
    add_column :leads, :region, :string
  end
end

class AddDefaultValueToStatusAttribute < ActiveRecord::Migration
  def change
    change_column :leads, :status, :string, :default => :new
  end
end

class AddMessageToAttachments < ActiveRecord::Migration[5.0]
  def change
    add_column :attachments, :message_id, :integer
  end
end

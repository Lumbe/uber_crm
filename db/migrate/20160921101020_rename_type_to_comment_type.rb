class RenameTypeToCommentType < ActiveRecord::Migration
  def change
    rename_column :comments, :type, :comment_type
  end
end

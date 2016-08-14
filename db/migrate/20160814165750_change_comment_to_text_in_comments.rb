class ChangeCommentToTextInComments < ActiveRecord::Migration
  def change
  	rename_column :comments, :comment, :text
  end
end

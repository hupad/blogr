class AddAttachmentCoverImageToBlogs < ActiveRecord::Migration
  def self.up
    change_table :blogs do |t|
      t.attachment :cover_image
    end
  end

  def self.down
    remove_attachment :blogs, :cover_image
  end
end

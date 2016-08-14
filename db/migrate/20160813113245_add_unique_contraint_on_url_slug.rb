class AddUniqueContraintOnUrlSlug < ActiveRecord::Migration
  def change
  	add_index :blogs, :url_slug, unique: true
  end
end

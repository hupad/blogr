class Post < ActiveRecord::Base

	validates :title, presence: true
	
	belongs_to :blog
	has_many :comments
end

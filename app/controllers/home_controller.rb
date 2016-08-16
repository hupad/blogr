class HomeController < ApplicationController

	def index
		@blogs = Blog.order('id desc')
	end
	
end

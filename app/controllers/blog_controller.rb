class BlogController < ApplicationController
	#before_action :authenticate_user!

	def new
		
	end

	def create
		@blog = Blog.create(blog_params)

		@blog.save

		redirect_to root_path
	end


	private
		def blog_params
			params.require(:blog).permit(:name, :url_slug)
		end
end

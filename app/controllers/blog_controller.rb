class BlogController < ApplicationController
	before_action :authenticate_user!

	def new
		@blog = Blog.new
	end

	def create
		@blog = current_user.blogs.build(blog_params)

		if @blog.save
			redirect_to root_path, notice: "A new blog has been created."
		else
			render :new
		end

	end


	private
		def blog_params
			params.require(:blog).permit(:name, :url_slug, :cover_image)
		end
end

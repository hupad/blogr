class PostsController < ApplicationController
	before_action :authenticate_user!, only: [:new, :create, :update, :edit, :destroy]
	before_action :get_blog_and_posts_from_slug, only: [:index, :create, :update, :edit, :destroy]

	def new
		@post = Post.new
	end

	def create
		@post = @blog.posts.build(permit_params)
		if @post.save
			redirect_to posts_path(params[:slug]), notice: "Your post has been created successfully."
		else
			render :new
		end
	end

	def index
		@posts = @blog.posts.order('id desc')
		@redcarpet = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
		@user_have_access = @blog.user == current_user
		
		respond_to do |format|
			format.html
			format.rss { render layout: false }
		end
	end

	def edit
		
	end

	def update
		if @post.update(permit_params)
			redirect_to posts_path(params[:slug]), notice: "Your post has be updated successfully."
		else
			render :edit
		end
	end

	def destroy
		if @post.destroy
			redirect_to posts_path(params[:slug]), notice: "Your post has been deleted successfully."
		end
	end

	private
		def permit_params
			params.require(:post).permit(:title, :content)
		end

		def get_blog_and_posts_from_slug
			@blog = Blog.find_by_slug params[:slug]
			@post = @blog.posts.find_by(id: params[:id])
		end
end
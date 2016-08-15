class CommentsController < ApplicationController
	before_action :get_blog_post_comments, only: [:index, :create]

def index
	@comments = @post.comments
end

def new
	@comment = Comment.new
end

def create
	@comment = @post.comments.build(permit_params)
	if @comment.save
		redirect_to comments_path(@blog.url_slug, params[:id]), notice: "Your comments has be posted successfully."
	else
		redirect_to comments_path(@blog.url_slug, params[:id]), flash: { error: "Cannot enter blank comment." }
	end
end


private
	
	def permit_params
		params.require(:comment).permit(:text)	
	end

	def get_blog_post_comments
		@blog = Blog.find_by_slug params[:slug]
		@post = @blog.posts.includes(:comments).find_by(id: params[:id])
	end

end
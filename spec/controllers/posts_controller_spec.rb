require 'rails_helper'
require 'byebug'

describe PostsController do

	let(:user)  { FactoryGirl.create(:user) }
	let(:blog)  { FactoryGirl.create(:blog) }
	let(:post) { FactoryGirl.create(:post, blog: blog) }

	describe "guest access" do
		describe "GET index" do
			it "the instnace variable @posts should have posts" do
				get :index, slug: blog.url_slug, id: post
				expect(assigns(:posts)).to match_array([post])
			end
		end

		describe "GET new" do
			it "should redirect to log in page" do
				get :new, slug: blog.url_slug
				expect(response).to redirect_to(new_user_session_url)
			end
		end
	end

	describe "authorized user" do

		before do
			sign_in(user)
		end

		describe "GET new" do
			it "should redirect to create new post page" do
				get :new, slug: blog.url_slug
				expect(response).to redirect_to(new_post_path(blog.url_slug))
			end
		end

		# describe "POST create" do
		# 	it "should create a post successfully"
		# 	it "it should redirect to posts page"
		# end

	end

end
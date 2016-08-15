require 'rails_helper'
require 'byebug'

describe PostsController do
	let(:user)  { FactoryGirl.create(:user) }
	let(:blog)  { FactoryGirl.create(:blog) }

	describe "guest access" do
		let(:post) { FactoryGirl.create(:post, blog: blog) }

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
				expect(response).to render_template('posts/new')
			end
			it "should have a new @post object" do
				get :new, slug: blog.url_slug
				expect(assigns[:post]).to be_a_new(Post)
			end
		end

		describe "POST create" do
			context "valid data" do
				let(:valid_data) { FactoryGirl.attributes_for(:post, blog_id: blog) }

				it "should create a post successfully" do
					expect{
						post :create, { post: valid_data, slug: blog.url_slug }
					}.to change(Post, :count).by(1)
				end
				# it "it should redirect to posts page"
			end
		end

	end

end
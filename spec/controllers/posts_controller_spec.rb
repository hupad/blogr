require 'rails_helper'

describe PostsController do
	let(:user)  { FactoryGirl.create(:user) }
	let(:blog)  { FactoryGirl.create(:blog, user: user) }

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
				let(:valid_data) { FactoryGirl.attributes_for(:post, blog: blog) }

				it "should create a post successfully" do
					expect{
						post :create, { post: valid_data, slug: blog.url_slug }
					}.to change(Post, :count).by(1)
				end

				it "it should redirect to posts page" do
					post :create, { post: valid_data, slug: blog.url_slug }
					expect(response).to redirect_to( posts_path(blog.url_slug) )
				end
			end

			context "invalid data" do
				let(:invalid_data) { FactoryGirl.attributes_for(:post, title: "", blog_id: blog) }

				it "should not create a post" do
					expect{
						post :create, { post: invalid_data, slug: blog.url_slug }
					}.not_to change(Post, :count)
				end

			end
		end

		describe "PATCH update" do
			let(:post) { FactoryGirl.create(:post, blog: blog) }

			context "valid update" do
				let(:valid_data) { FactoryGirl.attributes_for( :post, title: "update title" ) }

				it "redirects to posts path" do
					patch :update, { post: valid_data, slug: blog.url_slug, id: post }
					expect(response).to redirect_to(posts_path(blog.url_slug))
				end

				it "updates post in the database" do
					patch :update, { post: valid_data, slug: blog.url_slug, id: post }
					post.reload
					expect(post.title).to eq("update title")
				end

			end
		end

		describe "DELETE delete" do
			let(:post) { FactoryGirl.create(:post, blog: blog) }

			it "redirects to posts path" do
				delete :destroy, { post: post, slug: blog.url_slug, id: post }
				expect(response).to redirect_to(posts_path(blog.url_slug))
			end

			it "deletes a post from the database" do
				delete :destroy, { post: post, slug: blog.url_slug, id: post }
				expect(Post.exists?(post.id)).to be_falsy
			end
		end

	end

end
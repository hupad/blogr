require 'rails_helper'

describe BlogController do
	
	describe "guest user" do
		describe 'GET new' do
			it "redirects to log in page" do
				get :new
				expect(response).to redirect_to(new_user_session_url)
			end
		end

		describe "POST create" do
			it "redirects to log in page" do
				post :create, blog: FactoryGirl.attributes_for(:blog)
				expect(response).to redirect_to(new_user_session_url)
			end
		end
	end

	describe "authenticated user" do

		let(:user) { FactoryGirl.create(:user) }
		before do
			sign_in(user)
		end

		describe 'GET new' do
			it 'renders :new template' do
				get :new
				expect(response).to render_template(:new)
			end

			it 'assigns new Blog to @blog variable' do
				get :new
				expect(assigns(:blog)).to be_a_new(Blog)
			end
		end

		describe 'POST create' do
			context "valid data" do
				let(:valid_data) { FactoryGirl.attributes_for(:blog, user: user) }

				it 'will create a new blog in database' do
					expect{
						post :create, blog: valid_data
					}.to change(Blog, :count).by(1)
				end

				it 'will redirect to root path' do
					post :create, blog: valid_data
					expect(response).to redirect_to(root_path)
				end
			end

			context "invalid data" do
				let(:invalid_data) { FactoryGirl.attributes_for(:blog, name: "", user: user) }

				it "will not create a new blog in database" do
					expect{
						post :create, blog: invalid_data
					}.not_to change(Blog, :count)
				end

			end
		end

	end
end
require 'rails_helper'

feature 'Create posts' do

	let(:user) { FactoryGirl.create(:user) }
	let(:blog) { FactoryGirl.create(:blog, user: user) }

	before do
		visit new_user_session_path

		fill_in('Email', with: user.email)
		fill_in('Password', with: user.password)

		click_on("Log in")
	end

	scenario "create new post with valid data" do
		
		visit posts_path(blog.url_slug)

		click_on "New Post"

		fill_in "Title", with: "New Title"
		fill_in "Content", with: "New content"

		click_on "Submit"

		expect(page).to have_content("posts")
		expect(page).to have_content("Your post has been created successfully.")
	end

	scenario "create new post with valid data" do
		
		visit posts_path(blog.url_slug)

		click_on "New Post"

		fill_in "Title", with: ""
		fill_in "Content", with: "New content"

		click_on "Submit"

		expect(page).to have_content("can't be blank")
	end

end
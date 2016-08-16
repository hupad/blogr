require 'rails_helper'

feature 'Edit a Post' do

	let(:user) { FactoryGirl.create(:user) }
	let(:blog) { FactoryGirl.create(:blog, user: user) }
	let(:post) { FactoryGirl.create(:post, blog: blog) }

	before do
		visit new_user_session_path

		fill_in('Email', with: user.email)
		fill_in('Password', with: user.password)

		click_on("Log in")
	end

	scenario "user edits a post with valid data" do

		visit edit_post_path(blog.url_slug, post.id)

		fill_in "Title", with: "Updated Title"
		fill_in "Content", with: "Updated content"

		click_on "Submit"

		expect(page).to have_content("posts")
		expect(page).to have_content("Your post has be updated successfully.")
		expect(page).to have_content("Updated Title")
		expect(page).to have_content("Updated content")

	end

	scenario "user edits a post with invalid data" do
		visit edit_post_path(blog.url_slug, post.id)

		fill_in "Title", with: ""
		fill_in "Content", with: "Updated content"

		click_on "Submit"

		expect(page).to have_content("can't be blank")
	end
	
end
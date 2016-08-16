require 'rails_helper'

feature "Deleting a Post" do
	let(:user) { FactoryGirl.create(:user) }
	let(:blog) { FactoryGirl.create(:blog, user: user) }
		
	before do
		visit new_user_session_path

		fill_in('Email', with: user.email)
		fill_in('Password', with: user.password)

		click_on("Log in")
	end

	scenario "should delete a post" do
		
		post = FactoryGirl.create(:post, blog: blog)

		visit posts_path(blog.url_slug)

		within "#post_#{post.id}" do
			click_link 'Delete'
		end

		expect(page).not_to have_content(post.title)
		expect(Post.count).to eq(0)

	end

end
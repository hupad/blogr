require 'rails_helper'

feature 'User Log In', type: feature do
	
	let(:user) { FactoryGirl.create(:user) }
	
	scenario "User logs in with valid credentials" do

		visit 'user/sign_in'

		fill_in('Email', with: user.email)
		fill_in('Password', with: user.password)

		click_on("Log in")

		expect(page).to have_content("List of Blogs")

	end


end
require 'rails_helper'
require 'byebug'

feature 'Create new blog' do
	let(:user) { FactoryGirl.create(:user) }

	before do

		visit new_user_session_path

		fill_in('Email', with: user.email)
		fill_in('Password', with: user.password)

		click_on("Log in")

	end

	scenario 'With valid data' do
		
		visit root_path
		
		click_on('Create Blog')

		fill_in('Name', with: 'My new shiny blog')
		fill_in('Url slug', with: 'shiny')

		click_on('Create')

		visit root_path

		expect(page).to have_content('My new shiny blog')
		
	end

	scenario "Gives error message on missing blog name" do

		visit root_path
		
		click_on('Create Blog')

		fill_in('Name', with: '')
		fill_in('Url slug', with: 'shiny')

		click_on('Create')

		expect(page).to have_content("can't be blank")
	end

end
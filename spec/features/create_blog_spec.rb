require 'rails_helper'


feature 'Create new blog' do
	scenario 'With valid data' do
		
		visit root_path
		
		click_on('Create Blog')

		fill_in('Name', with: 'My new shiny blog')
		fill_in('Url slug', with: 'shiny')

		click_on('Create')

		visit root_path

		expect(page).to have_content('My new shiny blog')

	end

	scenario 'with no name' do

		visit root_path

		click_on('Create Blog')

		fill_in('Name', with: '')
		fill_in('Url slug', with: 'shiny')

		click_on('Create')

		expect(page).to have_content("can't be blank")

	end

	scenario 'with no url slug' do

		visit root_path

		click_on('Create Blog')

		fill_in('Name', with: 'Some name')
		fill_in('Url slug', with: '')

		click_on('Create')

		expect(page).to have_content("can't be blank")

	end
end
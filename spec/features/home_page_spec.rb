require 'rails_helper'

feature 'home page' do 
	scenario 'Welcome message' do

		visit root_path
		expect(page).to have_content('List of Blogs')

	end
end
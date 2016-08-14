require 'rails_helper'


feature 'Create posts' do
	
	scenario 'with valid data' do

		visit root_path

		click_on("")

		fill_in("Title", with: "Random post")
		fill_in("content", with: "Some random title")

		click_on('Submit')

	end

	scenario 'with invalid data' do

	end

end
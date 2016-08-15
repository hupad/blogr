FactoryGirl.define do
	factory :blog do
		name Faker::Lorem.word 
		url_slug Faker::Lorem.word
		cover_image_file_name "images2.jpeg"
		cover_image_content_type "image/jpeg"
	end
end
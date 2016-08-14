# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Blog.delete_all



def random_string()
  chars = 'abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ23456789'
  random_string = ''
  10.times { random_string << chars[rand(chars.size)] }
  random_string
end

10.times do |i|

	slug = random_string()
	blog = Blog.create(name: "A new blog title #{i}", url_slug: slug)

	post = Post.create(title: "A new post #{i}", content: "Some random content #{i}", blog_id: blog.id)
end
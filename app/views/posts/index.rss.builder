#encoding: UTF-8

xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title @blog.url_slug + "posts"
    xml.language "en"

    for post in @posts
    	xml.item do
    		xml.title post.title
    		xml.text post.content
    	end
    end
  end
end
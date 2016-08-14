module BlogHelper

	def user_has_access_to_edit?(logged_in_user, blog_owner)
		return @blog.user == current_user
	end

end

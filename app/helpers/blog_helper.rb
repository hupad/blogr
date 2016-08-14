module BlogHelper

	def user_has_access?(blog_owner)
		return @blog.user == current_user && user_signed_in?
	end

end

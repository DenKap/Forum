module ApplicationHelper

	def user_default_path(user)
		if user.has_role?(Role.admin)
			admin_root_path
		else
			root_path
		end
	end

end
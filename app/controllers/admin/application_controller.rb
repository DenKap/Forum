class Admin::ApplicationController < ApplicationController

	layout "admin"
	
	before_action :check_admin

	def check_admin
		if @current_user.blank?
			redirect_to root_path
		else
			unless @current_user.has_role?(Role.admin)
				redirect_to root_path
			end
		end		
	end

end
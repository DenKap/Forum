class SessionsController < ApplicationController

	include ApplicationHelper

	def new
	end

	def create
		user = User.authenticate(params[:login], params[:password])
    if user 			
 			session[:user_id] = user.id
 			redirect_to user_default_path(user), notice: "Welcome! You've been logged in"
    else      
			redirect_to login_path, alert: "There was a problem logging you in"
		end
	end

	def destroy
		session[:user_id] = nil		
		redirect_to root_path, notice: "You've been logged out successfully"
	end
	
end

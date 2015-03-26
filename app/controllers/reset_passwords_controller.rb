class ResetPasswordsController < ApplicationController

	before_action :set_user, only: [:show, :edit, :update]

	def new		
	end

	def create
		user = User.find_by(email: params[:email]) rescue nil
		if user.blank?
			redirect_to root_path, alert: "User not found"
		else
			user.reset_password!
			UserMailer.reset_password(user).deliver
			redirect_to reset_password_path(user.reset_password_token)
		end
	end

	def show
	end

	def edit
	end

	def update
		@user.password = params[:password]
		if @user.save
			@user.update(reset_password_token: nil, reset_password_requested_at: nil)
			session[:user_id] = @user.id
			redirect_to user_path(@user), notice: "Password has been changed successfully"
		else
			redirect_to edit_reset_password_path(@user.reset_password_token), alert: "Password should be at least 8 characters"
		end		
	end

  private

	def set_user
		@user = User.find_by(reset_password_token: params[:id]) rescue nil
		if @user.blank? 
			redirect_to root_path, alert: "User not found"
		end		
	end

end

class UsersController < ApplicationController

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
 			redirect_to user_path(@user), notice: "#{@user} joined the Forum"
 			else
 			flash[:alert] = "There was a problem. Please try again."
 			render :new
 		end
	end

	def show
		@user = User.find(params[:id]) rescue nil
		if @user.blank? 
			redirect_to root_path, alert: "User not found"
		end
	end

	private

	def user_params
		params.require(:user).permit(:login, :email, :password)		
	end

end

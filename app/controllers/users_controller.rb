class UsersController < ApplicationController

	before_action :set_user, only: [:show, :edit, :update]
	before_action :users_filter, only: [:edit, :update]

	def new
		@user = User.new
	end

	def create
		@user = User.new(new_user_params)
		if @user.save
 			redirect_to user_path(@user), notice: "#{@user.login} joined the Forum"
 		else
 			render :new
 		end
	end

	def show
		@last_posts = @user.posts.last(5)
		@last_topics = @user.topics.last(5)
	end

	def edit		
	end

	def update
		if @user.update(profile_params)
			redirect_to user_path(@user), notice: "Profile has been updated successfully"
    else
      render :edit
    end
	end

	def change_password
	end

	def update_password
		if @current_user.password == Digest::SHA1.hexdigest(params[:current_password])
			@current_user.new_password = params[:new_password]
			if @current_user.save
				redirect_to user_path(@current_user), notice: "Password has been changed successfully"
			else
				redirect_to user_path(@current_user), alert: "Password should be at least 8 characters"
			end
		else
			redirect_to user_path(@current_user), alert: "Wrong current password"
		end
	end

	private

	def set_user
		@user = User.find(params[:id]) rescue nil
		if @user.blank? 
			redirect_to root_path, alert: "User not found"
		end		
	end

	def users_filter
		if @current_user != @user
			redirect_to root_path
		end			
	end

	def new_user_params
		params.require(:user).permit(:login, :email, :password)	
	end

	def profile_params
		params.require(:user).permit(:login, :email, :city, :first_name, :last_name, :new_password)	
	end

end

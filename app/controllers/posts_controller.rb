class PostsController < ApplicationController

	before_action :check_logged_in
	before_action :set_topic
	before_action :set_post, only: [:edit, :update, :destroy]
	before_action :check_access, except: :create

	def create
		@post = @topic.posts.new(post_params)
		@post.user_id = @current_user.id

		respond_to do |format|

			format.html do
				if @post.save
					redirect_to category_topic_path(@topic.category, @topic), notice: "Your post has been added"
		    else
		      redirect_to category_topic_path(@topic.category, @topic), alert: "Please try again"
		    end
			end

			format.js do
				@post.save
				render :save
			end

		end


	end

	def edit		
	end

	def update
		if @post.update(post_params)
			redirect_to category_topic_path(@topic.category, @topic), notice: "Your post has been updated successfully"
    else
      render :edit
    end		
	end

	def destroy
		if @post.destroy
			redirect_to category_topic_path(@topic.category, @topic), notice: "Your post has been removed"
    else
      redirect_to category_topic_path(@topic.category, @topic), alert: "Couldn't remove this post"
    end
	end

	private

	def set_post
		@post = @topic.posts.find(params[:id])
    if @post.blank?
      redirect_to category_topic_path(@topic.category, @topic), alert: "Couldn't find this post"
 		else
 			if @post.created_at < 2.hours.ago
 				redirect_to category_topic_path(@topic.category, @topic), alert: "You can't change post"
 			end	
 		end
	end

	def set_topic
    @topic = Topic.find(params[:topic_id]) rescue nil
		if @topic.blank?
			redirect_to root_path, alert: "Couldn't find this topic"
		end
	end

	def check_access
		redirect_to root_path unless @current_user.can_edit_post?(@post)
	end

	def post_params
		params.require(:post).permit(:description, :user_id, :topic_id)
	end

end

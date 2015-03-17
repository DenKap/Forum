class TopicsController < ApplicationController
	
	before_action :check_logged_in, except: :show
	before_action :set_category
	before_action :set_topic, only: [:edit, :update, :destroy, :show]
	before_action :check_access, except: [:show, :new, :create]

	def show
		@post = @topic.posts.new
		@posts = @topic.posts
	end

	def new
		@topic = @category.topics.new
	end

	def create
		@topic = @category.topics.new(topic_params)
		@topic.user_id = @current_user.id
		if @topic.save
			redirect_to category_path(@category), notice: "#{@topic.title} has been added"
    else
      render :new
    end
	end

	def edit		
	end

	def update
		if @topic.update(topic_params)
			redirect_to category_path(@category), notice: "#{@topic.title} has been updated successfully"
    else
      render :edit
    end
	end

	def destroy
		if @topic.destroy
			redirect_to category_path(@category), notice: "#{@topic.title} has been removed"
    else
      redirect_to category_path(@category), alert: "Couldn't remove #{@topic.title}"
    end
	end

	private

	def set_topic
		@topic = @category.topics.find(params[:id])
    if @topic.blank?
      redirect_to category_path(@category), alert: "Couldn't find this topic"
    end		
	end

	def set_category
		@category = Category.find(params[:category_id]) rescue nil
		if @category.blank? 
			redirect_to root_path, alert: "Category not found"
		end
	end

	def check_access
		redirect_to root_path unless @current_user.can_edit_topic?(@topic)
	end

	def topic_params
		params.require(:topic).permit(:title, :description, :user_id, :category_id)
	end

end

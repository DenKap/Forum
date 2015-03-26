class CategoriesController < ApplicationController

	def show
		@category = Category.find(params[:id]) rescue nil
		if @category.blank? 
			redirect_to root_path, alert: "Category not found"
		else
			@topics = @category.topics.paginate(:page => params[:page], :per_page => 10).includes(:posts).order("posts.created_at DESC")
		end			
	end

end

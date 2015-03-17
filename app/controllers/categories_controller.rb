class CategoriesController < ApplicationController

	def show
		@category = Category.find(params[:id]) rescue nil
		if @category.blank? 
			redirect_to root_path, alert: "Category not found"
		else 
			@topics = @category.topics
		end			
	end

end

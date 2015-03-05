class Admin::CategoriesController < Admin::ApplicationController

	def index

	end

	def new
		@category = Category.new
	end

end

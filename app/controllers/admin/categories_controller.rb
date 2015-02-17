class Admin::CategoriesController < ApplicationController

	def index

	end

	def new
		@category = Category.new
	end

end

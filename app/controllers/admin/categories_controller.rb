class Admin::CategoriesController < Admin::ApplicationController

	before_action :set_category, only: [:edit, :update, :destroy]

	def index
		@categories = Category.all
	end

	def new
		@category = Category.new
	end

	def create
		@category = Category.new(category_params)
		if @category.save
			redirect_to admin_categories_path, notice: "#{@category.name} has been added"
    else
      render :new
    end
	end

	def edit		
	end

	def update
		if @category.update(category_params)
			redirect_to admin_categories_path, notice: "#{@category.name} has been updated successfully"
    else
      render :edit
    end
	end

	def destroy
		if @category.destroy
			redirect_to admin_categories_path, notice: "#{@category.name} has been removed"
    else
      redirect_to admin_categories_path, alert: "Couldn't remove #{@category.name}"
    end
	end

	private

	def set_category
		@category = Category.find(params[:id])
    if @category.blank?
      redirect_to admin_categories_path, alert: "Couldn't find such category"
    end
		
	end

	def category_params
		params.require(:category).permit(:name, :description)
	end

end

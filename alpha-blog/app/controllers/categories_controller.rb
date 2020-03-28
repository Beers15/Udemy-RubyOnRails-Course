class CategoriesController < ApplicationController
	before_action :require_admin, except: [:index, :show]

	def index
		@categories = Category.paginate(page: params[:page], per_page: 4)
	end

	def show

	end

	def new
		@category = Category.new
	end

	def create 
		@category = Category.new(category_params)

		if @category.save
			flash[:success] = "Category created successfully"
			redirect_to categories_path
		else
			render 'new'
		end
	end

	private

	def category_params
		params.require(:category).permit(:name)
	end

	def require_admin
		if !logged_in? || (logged_in && !current_user.admin?)
			flash[:danger] = "You don't have permission to do that."
			redirect_to categories_path
		end
	end
end

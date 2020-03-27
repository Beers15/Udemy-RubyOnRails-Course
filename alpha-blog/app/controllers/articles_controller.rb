class ArticlesController < ApplicationController
	before_action :set_article, only: [:edit, :update, :show, :destroy]
	before_action :require_user, except: [:index, :show]
	before_action :require_same_user, only: [:edit, :destroy]

	def index
		@articles = Article.paginate(page: params[:page], per_page: 4)
	end

	def show
		set_article
	end

	def new
		@article = Article.new
	end

	def create
		@article = Article.new(get_params)
		@article.user = current_user
		
		if @article.save
			flash[:success] = "Article successfully created!"
			redirect_to article_path(@article)
		else
		   render 'new'
		end		
	end

	def edit
		set_article
	end

	def update
		set_article
		if @article.update(get_params)
			flash[:success] = "Article successfully updated!"
			redirect_to article_path(@article)
		else
			render 'edit'
		end
	end

	def destroy
		@article = Article.find(params[:id])
		@article.destroy
		flash[:danger] = "Article deleted!"

		redirect_to articles_path
	end


	private 

	def set_article
		@article = Article.find(params[:id])
	end 

	def get_params
		params.require(:article).permit(:title, :description)
	end

	def require_same_user
		if current_user != @article.user and !current_user.admin?
			flash[:danger] = "You don't have permission to do that."
			redirect_to root_path
		end
	end
end
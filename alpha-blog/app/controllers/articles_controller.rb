class ArticlesController < ApplicationController
	before_action :set_article, only: [:edit, :update, :show, :destroy]

	def index
		@articles = Article.all
	end

	def new
		@article = Article.new
	end

	def create
		@article = Article.new(get_params)
		
		if @article.save
			flash[:notice] = "Article successfully created!"
			redirect_to article_path(@article)
		else
		   render 'new'
		end		
	end

	def show
		set_article
	end

	def edit
		set_article
	end

	def update
		set_article
		if @article.update(get_params)
			flash[:notice] = "Article successfully updated!"
			redirect_to article_path(@article)
		else
			render 'edit'
		end
	end

	def destroy
		@article = Article.find(params[:id])
		@article.destroy
		flash[:notice] = "Article deleted!"

		redirect_to articles_path
	end


	private 

	def set_article
		@article = Article.find(params[:id])
	end 

	def get_params
		params.require(:article).permit(:title, :description)
	end
end
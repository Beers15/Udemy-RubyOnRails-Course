class ArticlesController < ApplicationController
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
		@article = Article.find(params[:id])
	end

	def edit
		@article = Article.find(params[:id])
	end

	def update
		@article = Article.find(params[:id])
		if @article.update(get_params)
			flash[:notice] = "Article successfully updated!"
			redirect_to article_path(@article)
		else
			render 'edit'
		end
	end

	private def get_params
		params.require(:article).permit(:title, :description)
	end
end
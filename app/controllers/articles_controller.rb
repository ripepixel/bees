class ArticlesController < ApplicationController
  before_filter :get_article_cats, :get_latest_articles

  def index
    @featured = Article.where("published = ?", true).last
  	@articles = Article.exclude_latest.where("published = ?", true).order("created_at DESC").limit(3)
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    if params[:permalink]
    	@article = Article.find_by_permalink(params[:permalink])
    	@comments = Comment.where("article_id = ? AND status = ?", @article.id, "Active").order("created_at ASC")
    	if @article.nil?
    	  redirect_to blog_url, alert: "Sorry, that page does not exist"
    	end
    	#raise ActiveRecord::RecordNotFound, "Page not found" if @article.nil?
  	else
  		@article = Article.find(params[:id])
		end
  end
  
  def all
      @articles = Article.where("published = ?", true).order("created_at DESC").paginate(:page => params[:page], :per_page => 3)
    end


  def category
  	categ = ArticleCategory.find_by_name(params[:name])
  	if categ.nil?
  		redirect_to blog_path
  	else
  		@articles = Article.where("article_category_id = ? AND published = ?", categ.id, true).order("created_at DESC").paginate(:page => params[:page], :per_page => 3)
  	end
  end


  def get_article_cats
    @article_cats = ArticleCategory.all(:include => :articles, :conditions => ["articles.published = ?", true])
  end

  def get_latest_articles
    @latest_articles = Article.where("published = ?", true).order("created_at DESC").limit(4)
  end
  
end

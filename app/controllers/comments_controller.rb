class CommentsController < ApplicationController
	def create
		@article = Article.find(params[:article_id])
		@comment = Comment.new(params[:comment])
		@comment.status = "Review"
		if @comment.save
			flash[:notice] = "Your comment was submitted to our review team and should appear shortly."
			redirect_to article_path(@article.permalink)
		else
			flash[:error] = "There was an error submitting your comment."
			redirect_to article_path(@article.permalink)
		end
	end
end

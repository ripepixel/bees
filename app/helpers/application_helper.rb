module ApplicationHelper
  
  def page_title
  	(@page_title + " - " if @page_title).to_s + 'Little Busy Bees - Childrens Craft Boxes'
  end
  
  def latest_blog_posts
  	Article.where("published = ?", true).order("created_at DESC").limit(4)
  end
  
end

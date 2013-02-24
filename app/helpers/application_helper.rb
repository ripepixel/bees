module ApplicationHelper
  
  def page_title
  	(@page_title + " - " if @page_title).to_s + 'Little Busy Bees - Childrens Craft Boxes'
  end
  
  def latest_blog_posts
  	Article.where("published = ?", true).order("created_at DESC").limit(4)
    #feed = FeedAbstract::Feed.new(Net::HTTP.get(URI.parse("http://littlebusybeesblog.tumblr.com/rss")))
  end
  
  def pluralize_without_count(count, noun, text = nil)
  if count != 0
    count == 1 ? "#{noun}#{text}" : "#{noun.pluralize}#{text}"
  end
end
  
end

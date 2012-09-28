class Article < ActiveRecord::Base
  attr_accessible :article_category_id, :body, :image, :permalink, :published, :title
  
  belongs_to :article_category
  has_many :comments
  
  
  
  mount_uploader :image, ImageUploader


    scope :exclude_latest, lambda {
    	latest = Article.where("published = ?", true).last
    	return [] unless latest
    	where("id <> #{latest.id}")
  	}

  	def previous_article
    	self.class.first(:conditions => ["created_at < ? AND published = ?", created_at, true], :order => "created_at desc")
  	end

  	def next_article
   		self.class.first(:conditions => ["created_at > ? AND published = ?", created_at, true], :order => "created_at asc")
  	end
end

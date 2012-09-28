class Comment < ActiveRecord::Base
  attr_accessible :article_id, :comment, :guest_email, :guest_username, :status
  
  belongs_to :article
  
  scope :review, where(:status => "Review")
end

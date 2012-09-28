ActiveAdmin.register Comment, :as => "ArticleComment" do
  scope :review
  
  menu :parent => "Articles"
end

ActiveAdmin.register BlogImage do
  menu :parent => "Articles"

    index :as => :grid do |image|
    	link_to(image_tag(image.image, size: "100x100"), admin_blog_image_path(image))
  	end


end

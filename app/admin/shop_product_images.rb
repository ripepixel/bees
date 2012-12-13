ActiveAdmin.register ShopProductImage do
  menu :parent => "Shop"

    index :as => :grid do |image|
    	link_to(image_tag(image.image, size: "100x100"), admin_shop_product_image_path(image))
  	end
end

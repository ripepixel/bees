class ShopProductImage < ActiveRecord::Base
  attr_accessible :image, :shop_product_id

  belongs_to :shop_product

  mount_uploader :image, ImageUploader
end

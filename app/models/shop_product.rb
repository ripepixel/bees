class ShopProduct < ActiveRecord::Base
  attr_accessible :cost, :details, :is_active, :name, :sell, :shop_product_category_id, :weight

  has_many :shop_product_images
  belongs_to :shop_product_category
  has_many :shop_cart_items
  has_many :shop_order_items

  before_destroy :ensure_not_referenced_by_any_shop_cart_item




  private

  def ensure_not_referenced_by_any_shop_cart_item
  	if shop_cart_items.empty?
  		return true
  	else
  		errors.add(:base, 'Cart Items present')
  		return false
  	end
  end



end

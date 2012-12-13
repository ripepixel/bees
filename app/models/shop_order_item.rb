class ShopOrderItem < ActiveRecord::Base
  attr_accessible :price, :quantity, :shop_order_id, :shop_product_id
  
  belongs_to :shop_order
  belongs_to :shop_product

  def total_price
  	shop_product.sell * quantity
  end
  
  def total_weight
    shop_product.weight * quantity
  end

  
end

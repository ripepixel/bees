class ShopCartItem < ActiveRecord::Base
  attr_accessible :quantity, :shop_cart_id, :shop_product_id

  belongs_to :shop_product
  belongs_to :shop_cart
  

  def total_price
  	shop_product.sell * quantity
  end
  
  def total_weight
    shop_product.weight * quantity
  end
  
  def total_quantity
    quantity
  end

end

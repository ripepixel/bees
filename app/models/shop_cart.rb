class ShopCart < ActiveRecord::Base
  has_many :shop_cart_items, :dependent => :destroy
  

  def total_cart_price
  	shop_cart_items.to_a.sum { |item| item.total_price }
  end

  def total_cart_weight
    shop_cart_items.to_a.sum { |item| item.total_weight }
  end
  
  def total_cart_quantity
    shop_cart_items.to_a.sum { |item| item.total_quantity }
  end
  
  def delivery_charge(weight)
    del = DeliveryCharge.where("weight_from < ? AND weight_to > ?", weight, weight)
    del.first.price
  end
    
end

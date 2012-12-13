class ShopOrderDelivery < ActiveRecord::Base
  attr_accessible :delivery_charge_id, :price, :shop_order_id, :total_weight
  
  belongs_to :shop_order
end

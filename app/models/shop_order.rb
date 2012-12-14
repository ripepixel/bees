class ShopOrder < ActiveRecord::Base
  attr_accessible :address, :name, :order_status_id, :resource_id, :telephone, :user_id, :order_total
  
  belongs_to :order_status
  belongs_to :user
  has_many :shop_order_items
  has_many :shop_order_deliveries

  scope :status_sort, lambda { |status| joins(:order_status).where("order_statuses.name = ?", status) }


  def total_order_price
  	shop_order_items.to_a.sum { |item| item.total_price }
  end

  def total_order_weight
    shop_order_items.to_a.sum { |item| item.total_weight }
  end
  
  def delivery_charge(weight)
    del = DeliveryCharge.where("weight_from < ? AND weight_to > ?", weight, weight)
    del.first.price
  end

  

end

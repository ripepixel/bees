class AddOrderTotalToShopOrders < ActiveRecord::Migration
  def change
    add_column :shop_orders, :order_total, :decimal
  end
end

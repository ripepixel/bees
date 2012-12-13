class CreateShopOrderDeliveries < ActiveRecord::Migration
  def change
    create_table :shop_order_deliveries do |t|
      t.integer :shop_order_id
      t.integer :delivery_charge_id
      t.decimal :total_weight, :precision => 8, :scale =>2
      t.decimal :price, :precision => 8, :scale =>2

      t.timestamps
    end
  end
end

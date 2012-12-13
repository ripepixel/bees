class CreateShopOrderItems < ActiveRecord::Migration
  def change
    create_table :shop_order_items do |t|
      t.integer :shop_order_id
      t.integer :shop_product_id
      t.integer :quantity
      t.decimal :price, :precision => 8, :scale =>2

      t.timestamps
    end
  end
end

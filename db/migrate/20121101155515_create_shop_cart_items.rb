class CreateShopCartItems < ActiveRecord::Migration
  def change
    create_table :shop_cart_items do |t|
      t.integer :shop_cart_id
      t.integer :shop_product_id
      t.integer :quantity

      t.timestamps
    end
  end
end

class CreateShopCarts < ActiveRecord::Migration
  def change
    create_table :shop_carts do |t|

      t.timestamps
    end
  end
end

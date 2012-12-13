class CreateShopOrders < ActiveRecord::Migration
  def change
    create_table :shop_orders do |t|
      t.integer :user_id
      t.string :name
      t.text :address
      t.string :telephone
      t.integer :order_status_id
      t.string :resource_id

      t.timestamps
    end
  end
end

class CreateShopProducts < ActiveRecord::Migration
  def change
    create_table :shop_products do |t|
      t.string :name
      t.text :details
      t.decimal :cost, :precision => 8, :scale =>2
      t.decimal :sell, :precision => 8, :scale =>2
      t.decimal :weight, :precision => 8, :scale =>2
      t.integer :shop_product_category_id
      t.boolean :is_active

      t.timestamps
    end
  end
end

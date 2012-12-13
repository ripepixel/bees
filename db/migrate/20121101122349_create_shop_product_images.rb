class CreateShopProductImages < ActiveRecord::Migration
  def change
    create_table :shop_product_images do |t|
      t.integer :shop_product_id
      t.string :image

      t.timestamps
    end
  end
end

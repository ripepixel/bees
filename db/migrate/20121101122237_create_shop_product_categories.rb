class CreateShopProductCategories < ActiveRecord::Migration
  def change
    create_table :shop_product_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end

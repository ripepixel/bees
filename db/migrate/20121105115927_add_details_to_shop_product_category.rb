class AddDetailsToShopProductCategory < ActiveRecord::Migration
  def change
    add_column :shop_product_categories, :details, :text
  end
end

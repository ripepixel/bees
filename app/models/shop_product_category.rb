class ShopProductCategory < ActiveRecord::Base
  attr_accessible :name, :details

  has_many :shop_products
end

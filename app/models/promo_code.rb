class PromoCode < ActiveRecord::Base
  attr_accessible :code, :details, :discount, :expiry_date, :product_id, :promo_type

  belongs_to :product
end

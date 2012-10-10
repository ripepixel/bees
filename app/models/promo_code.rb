class PromoCode < ActiveRecord::Base
  attr_accessible :code, :details, :discount, :expiry_date, :product_id, :promo_type, :one_time

  belongs_to :product
  has_many :promo_uses
end

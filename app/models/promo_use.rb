class PromoUse < ActiveRecord::Base
  attr_accessible :promo_code_id, :subscription_id, :user_id
end

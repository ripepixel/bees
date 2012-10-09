class PromoUse < ActiveRecord::Base
  attr_accessible :promo_code_id, :subscription_id, :user_id

  belongs_to :subscription
  belongs_to :user
  belongs_to :promo_code
end

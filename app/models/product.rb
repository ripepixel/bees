class Product < ActiveRecord::Base
  attr_accessible :details, :has_sibling, :image, :is_subscription, :name, :sub_frequency, :sub_period, :sub_price
  
  has_many :subscription_items
  has_many :promo_codes
  
  mount_uploader :image, ImageUploader
  
  
  
  def name_with_sub_price
      "#{name} - #{helpers.number_to_currency(sub_price)}"
    end

    def name_with_gift_price
      "#{name} - #{helpers.number_to_currency(gift_price)}"
    end

    def helpers
      ActionController::Base.helpers
    end
  
end

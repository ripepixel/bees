class Subscription < ActiveRecord::Base
  attr_accessible :county, :first_delivery, :postcode, :resource_id, :status, :street, :town, :user_id, :subscription_items_attributes, :product_id, :gift_message, :promo_code
  attr_accessor :product_id, :promo_code
  
  has_many :subscription_items, dependent: :destroy
  has_many :products, :through => :subscription_items
  has_many :promo_uses
  has_many :promo_codes, through: :promo_uses
  belongs_to :user
  
  accepts_nested_attributes_for :subscription_items, allow_destroy: true
  
  
  validates_presence_of :street, :town, :county, :postcode
  validates_associated :subscription_items
  
end

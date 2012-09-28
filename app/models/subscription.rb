class Subscription < ActiveRecord::Base
  attr_accessible :county, :first_delivery, :postcode, :resource_id, :status, :street, :town, :user_id, :subscription_items_attributes, :product_id, :gift_message
  attr_accessor :product_id
  
  has_many :subscription_items, dependent: :destroy
  has_many :products, :through => :subscription_items
  belongs_to :user
  
  accepts_nested_attributes_for :subscription_items, allow_destroy: true
  
  
  validates_presence_of :street, :town, :county, :postcode
  validates_associated :subscription_items
  
end
